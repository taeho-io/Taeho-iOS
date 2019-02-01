//
//  LogInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import SwiftGRPC
import GoogleSignIn

class SignInWithEmailViewController: UIActivityIndicatorViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessagesLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.becomeFirstResponder()
    }

    @IBAction func logInButtonPressed(_ sender: Any) {
        showActivityIndicator()
        errorMessagesLabel.text = nil

        var logInRequest = User_LogInRequest()
        logInRequest.userType = .email
        logInRequest.email = emailText.text ?? ""
        logInRequest.password = passwordText.text ?? ""

        userClient.logIn(logInRequest, metadata: Metadata())
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] resp in
                    defer {
                        self?.hideActivityIndicator()
                    }

                    Auth.shared.updateUserTokenInfo(
                            accessToken: resp.accessToken,
                            refreshToken: resp.refreshToken,
                            userId: resp.userID,
                            expiresIn: resp.expiresIn)

                    self?.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
                }, onError: { [weak self] error in
                    defer {
                        self?.hideActivityIndicator()
                    }

                    if let rpcError: RPCError = error as? RPCError {
                        self?.errorMessagesLabel.text = rpcError.callResult?.statusMessage
                    } else {
                        self?.errorMessagesLabel.text = error.localizedDescription
                    }
                    self?.errorMessagesLabel.sizeToFit()
                })
                .disposed(by: disposeBag)
    }

}
