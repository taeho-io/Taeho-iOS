//
//  SignUpViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import SwiftGRPC

class SignUpWithEmailViewController: UIActivityIndicatorViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var errorMessagesLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.becomeFirstResponder()
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        showActivityIndicator()
        errorMessagesLabel.text = nil

        var registerRequest = User_RegisterRequest()
        registerRequest.userType = .email
        registerRequest.email = emailText.text ?? ""
        registerRequest.password = passwordText.text ?? ""
        registerRequest.name = nameText.text ?? ""

        userClient.register(registerRequest, metadata: Metadata())
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] resp in
                defer { self?.hideActivityIndicator() }

                Auth.shared.updateUserTokenInfo(
                        accessToken: resp.accessToken,
                        refreshToken: resp.refreshToken,
                        userId: resp.userID,
                        expiresIn: resp.expiresIn)

                self?.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
            }, onError: { [weak self] error in
                defer { self?.hideActivityIndicator() }

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
