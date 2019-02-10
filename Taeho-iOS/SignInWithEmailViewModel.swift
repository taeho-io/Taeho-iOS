//
// Created by Taeho Kim on 2019-01-31.
// Copyright (c) 2019 taeho.io. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftGRPC

class SignInWithEmailModel {

    var email = ""
    var password = ""


    convenience init(email: String, password: String) {
        self.init()

        self.email = email
        self.password = password
    }
}

class SignInWithEmailViewModel {

    let model: SignInWithEmailModel = SignInWithEmailModel()
    let disposeBag = DisposeBag()

    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()

    let isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMsg: BehaviorRelay<String?> = BehaviorRelay(value: "")


    func validate() -> Bool {
        let isValid = emailViewModel.validate() && passwordViewModel.validate()
        if !isValid {
            var errorValue = ""
            if !emailViewModel.validate(), let emailErrorValue: String = emailViewModel.errorValue.value {
                errorValue += emailErrorValue + "\n"
            }
            if !passwordViewModel.validate(), let passwordErrorValue: String = passwordViewModel.errorValue.value {
                errorValue += passwordErrorValue + "\n"
            }
            errorMsg.accept(errorValue)
            return false
        }
        errorMsg.accept("")
        return true
    }

    func signInWithEmail() {
        model.email = emailViewModel.data.value
        model.password = passwordViewModel.data.value

        self.isLoading.accept(true)

        var logInRequest = User_LogInRequest()
        logInRequest.userType = .email
        logInRequest.email = model.email
        logInRequest.password = model.password

        userClient.logIn(logInRequest, metadata: Metadata())
            .subscribe(onNext: { resp in
                self.emailViewModel.data.accept("")
                self.passwordViewModel.data.accept("")
                self.errorMsg.accept("")

                Auth.shared.updateUserTokenInfo(
                        accessToken: resp.accessToken,
                        refreshToken: resp.refreshToken,
                        userId: resp.userID,
                        expiresIn: resp.expiresIn)

                self.isLoading.accept(false)
                self.isSuccess.accept(true)
            }, onError: { error in
                self.isLoading.accept(false)
                self.isSuccess.accept(false)

                if let rpcError: RPCError = error as? RPCError {
                    self.errorMsg.accept(rpcError.callResult?.statusMessage)
                } else {
                    self.errorMsg.accept(error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
    }
}
