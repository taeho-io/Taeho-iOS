//
//  KeyStore.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation
import KeychainAccess

internal class KeyStore {

    private static var sharedKeyStore: KeyStore = {
        let keyStore = KeyStore()
        return keyStore
    }()

    private init() {}

    class var shared: KeyStore {
        return sharedKeyStore
    }


    let keychain = Keychain(service: "io.taeho.taeho-ios-token")

    var accessToken: String? {
        get {
            return keychain["accessToken"]
        }
        set {
            keychain["accessToken"] = newValue
        }
    }

    var refreshToken: String? {
        get {
            return keychain["refreshToken"]
        }
        set {
            keychain["refreshToken"] = newValue
        }
    }

    var userId: Int64? {
        get {
            guard let userIdString: String = keychain["userId"] else {
                return nil
            }
            guard let userId: Int64 = Int64(userIdString) else {
                return nil
            }
            return userId
        }
        set {
            guard let userId: Int64 = newValue else {
                return
            }
            keychain["userId"] = String(userId)
        }
    }

    var expiresIn: Int64? {
        get {
            guard let expiresInString: String = keychain["expiresIn"] else {
                return nil
            }
            guard let expiresIn: Int64 = Int64(expiresInString) else {
                return nil
            }
            return expiresIn
        }
        set {
            guard let expiresIn: Int64 = newValue else {
                return
            }
            keychain["expiresIn"] = String(expiresIn)
        }
    }

}
