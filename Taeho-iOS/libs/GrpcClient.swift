//
//  clients.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation
import SwiftGRPC

internal final class GrpcClient {

    private static let _authClient: Auth_AuthServiceClient =
            Auth_AuthServiceClient(address: GRPC_SERVER_ADDRESS, secure: GRPC_SERVER_SECURE)
    private static let _userClient: User_UserServiceClient =
            User_UserServiceClient(address: GRPC_SERVER_ADDRESS, secure: GRPC_SERVER_SECURE)


    internal static var authClient: Auth_AuthServiceClient {
        get { return _authClient }
    }

    internal static var userClient: User_UserServiceClient {
        get { return _userClient }
    }

}
