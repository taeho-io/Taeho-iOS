//
//  clients.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation

internal final class GrpcClient {

    var address = "api.taeho.io:443"
    var secure = true


    private static var sharedGrpcClient: GrpcClient = {
        let grpcClient = GrpcClient()
        return grpcClient
    }()

    class var shared: GrpcClient {
        return sharedGrpcClient
    }

    private init() {}

    internal func AuthClient() -> Auth_AuthServiceClient {
        return Auth_AuthServiceClient(address: self.address, secure: self.secure)
    }

    internal func UserClient() -> User_UserServiceClient {
        return User_UserServiceClient(address: self.address, secure: self.secure)
    }
    
}
