//
//  LogInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftGRPC
import GoogleSignIn

class SignInWithEmailViewController: UIActivityIndicatorViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessagesLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!

    let viewModel = SignInWithEmailViewModel()
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        createViewModelBinding()
        createCallbacks()

        emailText.becomeFirstResponder()
    }

    func createViewModelBinding() {
        emailText.rx.text.orEmpty
            .bind(to: viewModel.emailViewModel.data)
            .disposed(by: disposeBag)

        passwordText.rx.text.orEmpty
            .bind(to: viewModel.passwordViewModel.data)
            .disposed(by: disposeBag)

        signInButton.rx.tap
            .do(onNext: { [unowned self] in
                self.emailText.resignFirstResponder()
                self.passwordText.resignFirstResponder()
            })
            .subscribe(onNext: { [unowned self] in
                if !self.viewModel.validate() {
                    self.errorMessagesLabel.sizeToFit()
                    return
                }
                self.viewModel.signInWithEmail()

            }).disposed(by: disposeBag)
    }

    func createCallbacks() {
        viewModel.isLoading.asObservable()
            .bind { isLoading in
                if isLoading {
                    self.showActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                }
            }
            .disposed(by: disposeBag)

        viewModel.isSuccess.asObservable()
            .bind { isSuccess in
                if isSuccess {
                    DispatchQueue.main.async {
                        self.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
                    }
                }
            }
            .disposed(by: disposeBag)

        viewModel.errorMsg.asObservable()
            .bind(to: self.errorMessagesLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.emailViewModel.data.asObservable()
            .bind(to: self.emailText.rx.text)
            .disposed(by: disposeBag)

        viewModel.passwordViewModel.data.asObservable()
            .bind(to: self.passwordText.rx.text)
            .disposed(by: disposeBag)
    }
}
