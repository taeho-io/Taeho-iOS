//
//  NotesTableViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/26/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import SwiftGRPC

class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
}

class NotesTableViewController: UITableViewController {

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    var notes: [Note_NoteMessage] = []

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

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityIndicator()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        tableView.rowHeight = 100

        showActivityIndicator()
        listNotes(offset: 0, limit: 20)
            .subscribe(onNext: { resp in
                self.notes = resp.notes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideActivityIndicator()
                }
            }, onError: { error in
                self.hideActivityIndicator()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NotesTableViewCell

        // Configure the cell...
        let note = notes[indexPath.row]
        cell.title.text = note.title
        cell.body.text = note.body
        cell.updatedAt.text = String(note.updatedAt)

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func listNotes(offset: Int64 = 0, limit: Int64 = 20) -> Observable<Note_ListResponse> {
        var listRequest = Note_ListRequest()
        listRequest.offset = offset
        listRequest.limit = limit

        let metadata = Metadata()
        if let accessToken: String = Auth.shared.accessToken {
            try? metadata.add(key: "authorization", value: "Bearer " + accessToken)
        }

        return noteClient.list(listRequest, metadata: metadata)
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        showActivityIndicator()
        listNotes(offset: 0, limit: 20)
            .subscribe(onNext: { resp in
                self.notes = resp.notes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideActivityIndicator()
                    sender.endRefreshing()
                }
            }, onError: { error in
                self.hideActivityIndicator()
                sender.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

}
