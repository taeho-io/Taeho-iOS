//
//  clients.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import Foundation


internal let authClient: Auth_AuthServiceClient =
        Auth_AuthServiceClient(address: GRPC_SERVER_ADDRESS, secure: GRPC_SERVER_SECURE)

internal let userClient: User_UserServiceClient =
        User_UserServiceClient(address: GRPC_SERVER_ADDRESS, secure: GRPC_SERVER_SECURE)

internal let noteClient: Note_NoteServiceClient =
        Note_NoteServiceClient(address: GRPC_SERVER_ADDRESS, secure: GRPC_SERVER_SECURE)
