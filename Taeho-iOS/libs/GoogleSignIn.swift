//
//  GoogleSignIn.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/7/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation
import GoogleSignIn
import RxSwift

internal class GoogleSignIn: NSObject, GIDSignInDelegate {

    private let disposeBag = DisposeBag()
    
    internal let signInCallbackStream = PublishSubject<GIDGoogleUser>()
    internal let signOutCallbackStream = PublishSubject<GIDGoogleUser>()

    private let userClient = GrpcClient.shared.UserClient()


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
            print("\(error.localizedDescription)")
            return
        }

        signInCallbackStream.onNext(user)
    }

    internal func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }

        signOutCallbackStream.onNext(user)
    }
}
