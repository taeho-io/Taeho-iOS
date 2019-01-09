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
    
    internal let signInWithGoogleCallbackStream = PublishSubject<(GIDGoogleUser?)>()
    internal let signOutWithGoogleCallbackStream = PublishSubject<(GIDGoogleUser?)>()


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
            signInWithGoogleCallbackStream.onNext(nil)

            print("\(error.localizedDescription)")
            return
        }

        signInWithGoogleCallbackStream.onNext(user)
    }

    internal func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            signOutWithGoogleCallbackStream.onNext(nil)

            print("\(error.localizedDescription)")
            return
        }

        signOutWithGoogleCallbackStream.onNext(user)
    }
}
