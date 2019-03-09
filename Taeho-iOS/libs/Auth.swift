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
        .interval(RxTimeInterval(RefreshAccessTokenInternal), scheduler: MainScheduler.asyncInstance)
    internal let signOutStream = PublishSubject<AnyObject?>()

    internal var shouldRefreshAccessTokenPeriodically = false


    private static var sharedAuth: Auth = {
        let auth = Auth()
        return auth
    }()

    class var shared: Auth {
        return sharedAuth
    }

    private func subscribeRefreshAccessTokenStream() {
        refreshAccessTokenStream
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

    private func subscribeSignOutStream() {
        signOutStream
            .subscribe(onNext: { _ in
                self.updateUserTokenInfo(false,
                        accessToken: nil,
                        refreshToken: nil,
                        userId: nil,
                        expiresIn: nil)
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

    internal func newMetadata() -> Metadata {
        let metadata = Metadata()
        if let accessToken: String = self.accessToken {
            try? metadata.add(key: "authorization", value: "Bearer " + accessToken)
        }
        return metadata
    }

    internal func updateUserTokenInfo(_ shouldRefreshAccessTokenPeriodically: Bool = true,
                                      accessToken: String?,
                                      refreshToken: String?,
                                      userId: Int64?,
                                      expiresIn: Int64?) {
        KeyStore.shared.accessToken = accessToken
        KeyStore.shared.refreshToken = refreshToken
        KeyStore.shared.userId = userId
        KeyStore.shared.expiresIn = expiresIn

        self.shouldRefreshAccessTokenPeriodically = shouldRefreshAccessTokenPeriodically

        let metadata = Metadata()
        let authHeaderKey: String = "Authorization".lowercased()
        if let accessToken: String = Auth.shared.accessToken {
            let authHeaderValue: String = "Bearer " + accessToken
            try? metadata.add(key: authHeaderKey, value: authHeaderValue)
        }
        userClient.metadata = metadata
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
                  let resp: Auth_RefreshResponse = resp
                    else {
                completion(AuthError.invalidResponse)
                return
            }

            self.updateUserTokenInfo(
                    accessToken: resp.accessToken,
                    refreshToken: resp.refreshToken,
                    userId: resp.userID,
                    expiresIn: resp.expiresIn)

            completion(nil)
        })
    }

}
