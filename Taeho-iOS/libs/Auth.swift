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
    case unauthenticated
    case invalidResponse
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

    internal let refreshAccessTokenStream = Observable<Int>
        .interval(RxTimeInterval(RefreshAccessTokenInternal), scheduler: MainScheduler.instance)
    internal let signOutStream = PublishSubject<AnyObject?>()

    internal var shouldRefreshAccessTokenPeriodically = false


    private static var sharedAuth: Auth = {
        let auth = Auth()
        return auth
    }()

    class var shared: Auth {
        return sharedAuth
    }

    func updateUserTokenInfo(accessToken: String, refreshToken: String, userId: Int64, expiresIn: Int64) {
        shouldRefreshAccessTokenPeriodically = true
        KeyStore.shared.accessToken = accessToken
        KeyStore.shared.refreshToken = refreshToken
        KeyStore.shared.userId = userId
        KeyStore.shared.expiresIn = expiresIn
    }

    func subscribeRefreshAccessTokenStream() {
        refreshAccessTokenStream
            .debug("refreshAccessTokenStream")
            .subscribe(onNext: { _ in
                guard self.shouldRefreshAccessTokenPeriodically else {
                    return
                }

                self.refreshAccessToken(completion: { (error) in
                    if error == AuthError.unauthenticated {
                        self.signOutStream.onNext(nil)
                        return
                    }
                })
            })
            .disposed(by: self.disposeBag)
    }

    func subscribeSignOutStream() {
        signOutStream
            .subscribe(onNext: { _ in
                Auth.shared.shouldRefreshAccessTokenPeriodically = false
                KeyStore.shared.refreshToken = nil
                KeyStore.shared.userId = nil
                KeyStore.shared.accessToken = nil
                KeyStore.shared.expiresIn = nil
            })
            .disposed(by: disposeBag)
    }

    private init() {
        subscribeRefreshAccessTokenStream()
        subscribeSignOutStream()
    }

    internal var userId: Int64? {
        get { return KeyStore.shared.userId }
        set { KeyStore.shared.userId = newValue }
    }

    internal var refreshToken: String? {
        get { return KeyStore.shared.refreshToken }
        set { KeyStore.shared.refreshToken = newValue }
    }

    internal var accessToken: String? {
        get { return KeyStore.shared.accessToken }
        set { KeyStore.shared.accessToken = newValue }
    }

    internal func refreshAccessToken(completion: @escaping (AuthError?) -> Void) {
        guard let refreshToken: String = KeyStore.shared.refreshToken else {
            completion(AuthError.noRefreshToken)
            return
        }

        var refreshRequest = Auth_RefreshRequest()
        refreshRequest.refreshToken = refreshToken

        authClient.metadata = Metadata()
        _ = try? authClient.refresh(refreshRequest, completion: { (resp, result) in
            if result.statusCode == .unauthenticated {
                completion(AuthError.unauthenticated)
                return
            }

            guard result.statusCode == .ok,
                  resp?.accessToken != "",
                  resp?.refreshToken != "",
                  resp?.expiresIn != 0,
                  resp?.userID != 0
                    else {
                completion(AuthError.invalidResponse)
                return
            }

            KeyStore.shared.accessToken = resp?.accessToken
            KeyStore.shared.refreshToken = resp?.refreshToken
            KeyStore.shared.userId = resp?.userID
            KeyStore.shared.expiresIn = resp?.expiresIn

            completion(nil)
        })

        //

    }

}
