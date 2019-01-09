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
            .debug("signInWithGoogleCallbackStream")
            .subscribe(onNext: { user in
                guard let user: GIDGoogleUser = user else {
                    self.hideActivityIndicator()
                    return
                }

                var signInWithGoogleRequest = User_SignInWithGoogleRequest()
                signInWithGoogleRequest.googleIDToken = user.authentication.idToken
                signInWithGoogleRequest.name = user.profile.name

                userClient.metadata = Metadata()
                _ = try? userClient.signInWithGoogle(signInWithGoogleRequest, completion: { (resp, result) in
                    defer {
                        self.hideActivityIndicator()
                    }

                    guard result.statusCode == .ok,
                          let resp: User_SignInWithGoogleResponse = resp
                            else {
                        return
                    }

                    Auth.shared.updateUserTokenInfo(
                            accessToken: resp.accessToken,
                            refreshToken: resp.refreshToken,
                            userId: resp.userID,
                            expiresIn: resp.expiresIn)

                    DispatchQueue.main.async {
                        self.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
                    }
                })
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityIndicator()
        initGoogleSignInButton()
        hideNavigationBarBackButton()
        subscribeSignInWithGoogleCallbackStream()
    }

    @IBAction func signInWithGooglePressed(_ sender: Any) {
        self.showActivityIndicator()
    }
}
