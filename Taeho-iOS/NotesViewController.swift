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

class NotesViewController: UIActivityIndicatorViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var rxLabel: UILabel!
    let labelText = BehaviorRelay(value: "0")


    override func viewDidLoad() {
        super.viewDidLoad()

        labelText.bind(to: rxLabel.rx.text)
            .disposed(by: disposeBag)

        var getRequest = User_GetRequest()
        getRequest.userID = Auth.shared.userId ?? 0

        let metadata = Metadata()
        let authHeaderKey: String = "Authorization".lowercased()
        if let accessToken: String = Auth.shared.accessToken {
            let authHeaderValue: String = "Bearer " + accessToken
            try? metadata.add(key: authHeaderKey, value: authHeaderValue)
        }

        showActivityIndicator()

        userClient.get(getRequest, metadata: metadata)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] resp in
                defer { self?.hideActivityIndicator() }

                self?.labelText.accept(resp.email)
                self?.rxLabel.sizeToFit()
            }, onError: { [weak self] error in
                defer { self?.hideActivityIndicator() }
            })
            .disposed(by: disposeBag)
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        Auth.shared.signOutStream.onNext(nil)
    }

}
