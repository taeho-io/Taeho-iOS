//
//  SignInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/9/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import SwiftGRPC
import GoogleSignIn

class SignInViewController: UIActivityIndicatorViewController, GIDSignInUIDelegate {

    let disposeBag = DisposeBag()

    @IBOutlet weak var signInWithGoogleButton: GIDSignInButton!


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
            .do { [weak self] in
                self?.showActivityIndicator()
            }
            .flatMap { user, error in
                return Observable<GIDGoogleUser>.create { observer in
                    if let user: GIDGoogleUser = user {
                        observer.onNext(user)
                    }
                    if let error: Error = error {
                        observer.onError(error)
                    }
                    return Disposables.create()
                }
            }
            .map { user -> User_SignInWithGoogleRequest in
                var signInWithGoogleRequest = User_SignInWithGoogleRequest()
                signInWithGoogleRequest.googleIDToken = user.authentication.idToken
                signInWithGoogleRequest.name = user.profile.name
                return signInWithGoogleRequest
            }
            .flatMap { signInWithGoogleRequest in
                return userClient.signInWithGoogle(signInWithGoogleRequest, metadata: Metadata())
            }
            .catchErrorJustReturn(User_SignInWithGoogleResponse())
            .subscribe(onNext: { [weak self] signInWithGoogleResponse in
                defer { self?.hideActivityIndicator() }

                if signInWithGoogleResponse.accessToken == "" {
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
                defer { self?.hideActivityIndicator() }
            }, onDisposed: { [weak self] in
                defer { self?.hideActivityIndicator() }
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
        //self.showActivityIndicator()
    }
}
