//
//  NotesTableViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/26/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftGRPC
import SwiftProtobuf

class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
}

class NotesTableViewController: UITableViewController {

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    let notes: BehaviorSubject<[Note_NoteMessage]> = BehaviorSubject(value: [])
    var tappedNoteRow: Int? = nil

    let disposeBag = DisposeBag()


    func initActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }

    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let noteEditViewController = segue.destination as? NoteEditViewController, let row: Int = tappedNoteRow {
            try? noteEditViewController.noteTextView.text = self.notes.value()[row].body

            noteEditViewController.noteTextView.rx.text
                .debounce(1, scheduler: MainScheduler.asyncInstance)
                .subscribe(onNext: { noteText in
                    if let noteText: String = noteText {
                        var notes = try? self.notes.value()
                        if noteText == notes?[row].body {
                            return
                        }
                        notes?[row].body = noteText
                        notes?[row].updatedAt = Google_Protobuf_Timestamp.init(date: Date())
                        if var notes: [Note_NoteMessage] = notes {
                            notes.sort(by: { $0.updatedAt.seconds > $1.updatedAt.seconds})
                            self.notes.onNext(notes)
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityIndicator()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Disable dataSource and delegate to use tableview rx bind to tableview
        tableView.dataSource = nil
        tableView.delegate = nil

        tableView.rowHeight = 100

        notes
            .bind(to: tableView.rx.items(cellIdentifier: "NoteCell", cellType: NotesTableViewCell.self)) { row, element, cell in
                cell.title.text = element.title
                cell.body.text = element.body
                cell.updatedAt.text = element.updatedAt.textFormatString()
            }
            .disposed(by: self.disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tappedNoteRow = indexPath.row
                self?.performSegue(withIdentifier: "SegueNoteEditView", sender: self)
            })
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
            })
            .disposed(by: disposeBag)

        showActivityIndicator()
        listNotes(offset: 0, limit: 20)
            .subscribe(onNext: { resp in
                self.notes.onNext(resp.notes)

                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            }, onError: { error in
                self.hideActivityIndicator()
            })
            .disposed(by: disposeBag)
    }

    func listNotes(offset: Int64 = 0, limit: Int64 = 20) -> Observable<Note_ListResponse> {
        var listRequest = Note_ListRequest()
        listRequest.offset = offset
        listRequest.limit = limit

        let metadata = Auth.shared.newMetadata()
        return noteClient.list(listRequest, metadata: metadata)
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        showActivityIndicator()
        listNotes(offset: 0, limit: 20)
            .subscribe(onNext: { resp in
                self.notes.onNext(resp.notes)

                DispatchQueue.main.async {
                    sender.endRefreshing()
                    self.hideActivityIndicator()
                }
            }, onError: { error in
                sender.endRefreshing()
                self.hideActivityIndicator()
            })
            .disposed(by: disposeBag)
    }

}
