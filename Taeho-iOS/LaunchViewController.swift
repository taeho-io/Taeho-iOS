//
//  LaunchViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/9/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import SwiftGRPC

class LaunchViewController: UIActivityIndicatorViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var signOutButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        signOutButton.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let refreshToken: String = Auth.shared.refreshToken else {
            self.performSegue(withIdentifier: "SegueLaunchToSignIn", sender: self)
            return
        }

        showActivityIndicator()

        var refreshRequest = Auth_RefreshRequest()
        refreshRequest.refreshToken = refreshToken

        authClient.refresh(refreshRequest, metadata: Metadata())
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .retryWhen { error in
                return error.enumerated().flatMap { [weak self] attempt, error -> Observable<Int> in
                    if let rpcError: RPCError = error as? RPCError {
                        if rpcError.callResult?.statusCode == .unauthenticated {
                            return Observable.error(error)
                        }
                    }
                    if attempt + 1 >= 3 {
                        if let self = self {
                            self.signOutButton.isHidden = false
                        }
                    }
                    return Observable<Int>.timer(3.0, scheduler: MainScheduler.asyncInstance).take(1)
                }
            }
            .subscribe(onNext: { [weak self] resp in
                defer { self?.hideActivityIndicator() }

                Auth.shared.updateUserTokenInfo(
                        accessToken: resp.accessToken,
                        refreshToken: resp.refreshToken,
                        userId: resp.userID,
                        expiresIn: resp.expiresIn)

                self?.parent?.performSegue(withIdentifier: "SegueLaunchToRootWithoutAnimation", sender: self)
            }, onError: { [weak self] error in
                defer { self?.hideActivityIndicator() }

                self?.performSegue(withIdentifier: "SegueLaunchToSignIn", sender: self)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func signOutPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueLaunchToSignIn", sender: self)
    }

}
