//
//  GoogleSignIn.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/7/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation
import RxSwift
import GoogleSignIn

internal class GoogleSignIn: NSObject, GIDSignInDelegate {

    private let disposeBag = DisposeBag()
    
    internal let signInWithGoogleCallbackStream = PublishSubject<(GIDGoogleUser?, Error?)>()
    internal let signOutWithGoogleCallbackStream = PublishSubject<(GIDGoogleUser?, Error?)>()


    private static var sharedGoogleSignIn: GoogleSignIn = {
        let googleSignIn = GoogleSignIn()

        GIDSignIn.sharedInstance()?.clientID = GOOGLE_SIGN_IN_CLIENT_ID
        GIDSignIn.sharedInstance()?.delegate = googleSignIn
        GIDSignIn.sharedInstance()?.shouldFetchBasicProfile = true

        return googleSignIn
    }()

    internal class var shared: GoogleSignIn {
        return sharedGoogleSignIn
    }

    private override init() {
        super.init()
    }

    internal func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            signInWithGoogleCallbackStream.onNext((nil, error))

            print("\(error.localizedDescription)")
            return
        }

        signInWithGoogleCallbackStream.onNext((user, nil))
    }

    internal func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            signOutWithGoogleCallbackStream.onNext((nil, error))

            print("\(error.localizedDescription)")
            return
        }

        signOutWithGoogleCallbackStream.onNext((user, nil))
    }
}
