//
//  Auth.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/6/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation
import RxSwift
import SwiftGRPC

enum AuthError: Error {
    case noRefreshToken
}

enum GrpcError: LocalizedError {
    case grpcError(errorMessage: String?)
}

extension GrpcError {
    var errorDescription: String? {
        switch self {
        case .grpcError(errorMessage: let errorMessage):
            return errorMessage
        }
    }
}

internal class Auth {

    private let disposeBag = DisposeBag()

    internal let logInStream = PublishSubject<User_LogInRequest>()
    internal let logInCallbackStream = PublishSubject<(User_LogInResponse, CallResult)>()
    internal let signInWithGoogleStream = PublishSubject<User_SignInWithGoogleRequest>()

    internal let refreshAccessTokenStream = Observable<Int>.interval(RxTimeInterval(60 * 5), scheduler: MainScheduler.instance)
    internal var shouldRefreshAccessTokenPeriodically = true

    private let authClient = GrpcClient.authClient
    private let userClient = GrpcClient.userClient
    private var _accessToken: String?


    private static var sharedAuth: Auth = {
        let auth = Auth()
        return auth
    }()

    class var shared: Auth {
        return sharedAuth
    }

    func initLogInStream() {
        logInStream
            .debug("logInStream")
            .subscribe(onNext: { (logInRequest) in
                _ = try? self.userClient.logIn(logInRequest, completion: { (resp, result) in
                    self.logInCallbackStream.onNext((resp ?? User_LogInResponse(), result))
                })
            })
            .disposed(by: disposeBag)
    }

    func initLogInCallbackStream() {
        logInCallbackStream
            .debug("logInCallbackStream")
            .subscribe(onNext: { (resp, result) in
                guard result.statusCode == .ok else {
                    return
                }

                KeyStore.shared.refreshToken = resp.refreshToken
                KeyStore.shared.userId = resp.userID
            })
            .disposed(by: disposeBag)
    }

    func initSignInWithGoogleStream() {
        signInWithGoogleStream
            .debug("signInWithGoogleStream")
            .subscribe(onNext: { (signInWithGoogleRequest) in
                _ = try? self.userClient.signInWithGoogle(signInWithGoogleRequest, completion: { (resp, result) in
                    var logInResponse = User_LogInResponse()
                    logInResponse.accessToken = resp?.accessToken ?? ""
                    logInResponse.refreshToken = resp?.refreshToken ?? ""
                    logInResponse.expiresIn = resp?.expiresIn ?? 0
                    logInResponse.userID = resp?.userID ?? 0

                    self.logInCallbackStream.onNext((logInResponse, result))
                })
            })
            .disposed(by: disposeBag)
    }

    func initRefreshAccessTokenStream() {
        self.refreshAccessTokenStream
            .debug("refreshTokenStream")
            .subscribe(onNext: {event in
                guard self.shouldRefreshAccessTokenPeriodically else {
                    return
                }

                try? self.refreshAccessToken()
            })
            .disposed(by: self.disposeBag)
    }

    private init() {
        initLogInStream()
        initLogInCallbackStream()
        initSignInWithGoogleStream()
        initRefreshAccessTokenStream()
    }

    internal var refreshToken: String? {
        get {
            return KeyStore.shared.refreshToken
        }
        set {
            KeyStore.shared.refreshToken = newValue
        }
    }

    internal var accessToken: String? {
        get {
            return self._accessToken
        }
        set {
            self._accessToken = newValue
        }
    }

    internal func refreshAccessToken() throws {
        guard let refreshToken: String = KeyStore.shared.refreshToken else {
            throw AuthError.noRefreshToken
        }

        var refreshRequest = Auth_RefreshRequest()
        refreshRequest.refreshToken = refreshToken

        _ = try? authClient.refresh(refreshRequest, completion: { (resp, result) in
            if result.statusCode == .unauthenticated {
                signOut()
                return
            }

            guard result.statusCode == .ok else {
                return
            }

            self.accessToken = resp?.accessToken
        })
    }

}

func signOut() {
    Auth.shared.refreshToken = nil
    Auth.shared.shouldRefreshAccessTokenPeriodically = false
    goToLogInController()
}

func goToLogInController() {
    changeRootViewController(storyboardName: "Main", viewControllerIdentifier: "LogInNavigationController")
}

func changeRootViewController(storyboardName: String, viewControllerIdentifier: String) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    DispatchQueue.main.async {
        appDelegate.window?.rootViewController = viewController
    }
}
