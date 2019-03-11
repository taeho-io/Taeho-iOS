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
        guard let noteEditViewController = segue.destination as? NoteEditViewController else {
            return
        }

        var row: Int = 0
        if let tappedNoteRow: Int = tappedNoteRow {
            row = tappedNoteRow
            try? noteEditViewController.noteID = self.notes.value()[row].noteID
            try? noteEditViewController.noteBodyTextView.text = self.notes.value()[row].body
        } else {
            var notes = try? self.notes.value()
            var newNote = Note_NoteMessage()
            guard let userId: Int64 = Auth.shared.userId else {
                return
            }
            newNote.noteID = UUID().uuidString
            newNote.createdBy = userId

            let ts = Google_Protobuf_Timestamp.init(date: Date())
            newNote.createdAt = ts
            newNote.updatedAt = ts

            notes?.insert(newNote, at: 0)

            guard let newNotes: [Note_NoteMessage] = notes else {
                return
            }
            self.notes.onNext(newNotes)
        }

        noteEditViewController.noteBodyTextView.rx.text
            //.debounce(1, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { noteBodyText in
                guard let noteBodyText: String = noteBodyText else {
                    return
                }

                var notes = try? self.notes.value()
                guard noteBodyText != notes?[row].body else {
                    return
                }
                notes?[row].body = noteBodyText
                notes?[row].updatedAt = Google_Protobuf_Timestamp.init(date: Date())

                guard var newNotes: [Note_NoteMessage] = notes else {
                    return
                }
                newNotes.sort(by: { $0.updatedAt.seconds > $1.updatedAt.seconds})
                self.notes.onNext(newNotes)
                row = 0
            })
            .disposed(by: disposeBag)
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
                self?.tappedNoteRow = nil
            })
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .subscribe(onNext: { indexPath in
                let notes = try? self.notes.value()
                guard var newNotes: [Note_NoteMessage] = notes else{
                    return
                }
                newNotes.remove(at: indexPath.row)
                self.notes.onNext(newNotes)
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let notes = try? self.notes.value()
        guard var newNotes: [Note_NoteMessage] = notes else{
            return
        }
        if newNotes.count > 0 && newNotes[0].title == "" && newNotes[0].body == "" {
            newNotes.remove(at: 0)
        }
        self.notes.onNext(newNotes)
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
