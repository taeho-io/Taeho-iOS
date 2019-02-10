//
//  SignInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/9/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftGRPC
import GoogleSignIn

class SignInViewController: UIActivityIndicatorViewController, GIDSignInUIDelegate {

    let disposeBag = DisposeBag()

    @IBOutlet weak var signInWithGoogleButton: GIDSignInButton!
    @IBOutlet weak var errorMessagesLabel: UILabel!


    func initGoogleSignInButton() {
        GIDSignIn.sharedInstance().uiDelegate = self
        signInWithGoogleButton.colorScheme = .light
        signInWithGoogleButton.style = .wide
    }

    func hideNavigationBarBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    func subscribeSignInWithGoogleCallbackStream() {
        GoogleSignIn.shared.signInWithGoogleCallbackStream
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            // check GoogleUser
            .flatMap { [weak self] user, error in
                return Observable<GIDGoogleUser>.create { observer in
                    if let user: GIDGoogleUser = user {
                        observer.onNext(user)
                    }
                    if let error: Error = error {
                        defer {
                            self?.hideActivityIndicator()
                        }
                    }
                    return Disposables.create()
                }
            }
            // map GoogleUser to SignInWithGoogleRequest
            .map { user -> User_SignInWithGoogleRequest in
                var signInWithGoogleRequest = User_SignInWithGoogleRequest()
                signInWithGoogleRequest.googleIDToken = user.authentication.idToken
                signInWithGoogleRequest.name = user.profile.name
                return signInWithGoogleRequest
            }
            // call signInWithGoogle API
            .flatMap { signInWithGoogleRequest in
                return Observable<User_SignInWithGoogleResponse>.create { observer in
                    return userClient.signInWithGoogle(signInWithGoogleRequest, metadata: Metadata())
                        .subscribe(onNext: { resp in
                            observer.onNext(resp)
                        }, onError: { [weak self] error in
                            defer {
                                self?.hideActivityIndicator()
                            }

                            DispatchQueue.main.async {
                                if let rpcError: RPCError = error as? RPCError {
                                    self?.errorMessagesLabel.text = rpcError.callResult?.statusMessage
                                } else {
                                    self?.errorMessagesLabel.text = error.localizedDescription
                                }
                                self?.errorMessagesLabel.sizeToFit()
                            }
                        })
                }
            }
            // sign in with token
            .subscribe(onNext: { [weak self] signInWithGoogleResponse in
                defer {
                    self?.hideActivityIndicator()
                }

                // return if already signed in.
                if let accessToken: String = Auth.shared.accessToken {
                    return
                }

                Auth.shared.updateUserTokenInfo(
                        accessToken: signInWithGoogleResponse.accessToken,
                        refreshToken: signInWithGoogleResponse.refreshToken,
                        userId: signInWithGoogleResponse.userID,
                        expiresIn: signInWithGoogleResponse.expiresIn)

                DispatchQueue.main.async {
                    self?.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
                }
            }, onError: { [weak self] error in
                defer {
                    self?.hideActivityIndicator()
                }
            }, onCompleted: { [weak self] in
                defer {
                    self?.hideActivityIndicator()
                }
            }, onDisposed: { [weak self] in
                defer {
                    self?.hideActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initGoogleSignInButton()
        hideNavigationBarBackButton()
        subscribeSignInWithGoogleCallbackStream()
    }

    @IBAction func signInWithGooglePressed(_ sender: Any) {
        self.errorMessagesLabel.text = nil
        self.showActivityIndicator()
    }
}
