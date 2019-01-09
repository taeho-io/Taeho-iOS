//
//  NotesViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/8/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import SwiftGRPC
import RxSwift
import RxCocoa

class NotesViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var rxLabel: UILabel!

    let labelText = BehaviorRelay(value: "0")


    override func viewDidLoad() {
        super.viewDidLoad()

        labelText.bind(to: rxLabel.rx.text)
            .disposed(by: disposeBag)

        let authHeaderKey: String = "Authorization".lowercased()
        if let accessToken: String = Auth.shared.accessToken {
            let authHeaderValue: String = "Bearer " + accessToken
            try? userClient.metadata.add(key: authHeaderKey, value: authHeaderValue)
        } else {
            userClient.metadata = Metadata()
        }

        var getRequest = User_GetRequest()
        getRequest.userID = Auth.shared.userId ?? 0

        _ = try? userClient.get(getRequest, completion: { (resp, result) in
            if let email: String = resp?.email {
                self.labelText.accept(email)
                DispatchQueue.main.async {
                    self.rxLabel.sizeToFit()
                }
            }
        })
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        Auth.shared.signOutStream.onNext(nil)
    }

}
