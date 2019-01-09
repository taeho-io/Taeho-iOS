//
//  LaunchViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/9/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import SwiftGRPC

class LaunchViewController: UIActivityIndicatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let refreshToken: String = Auth.shared.refreshToken else {
            self.performSegue(withIdentifier: "SegueLaunchToSignIn", sender: self)
            return
        }

        showActivityIndicator()

        var refreshRequest = Auth_RefreshRequest()
        refreshRequest.refreshToken = refreshToken

        authClient.metadata = Metadata()
        _ = try? authClient.refresh(refreshRequest, completion: { (resp, result) in
            defer {
                self.hideActivityIndicator()
            }

            guard result.statusCode == .ok,
                  resp?.accessToken != "",
                  resp?.refreshToken != "",
                  resp?.expiresIn != 0,
                  resp?.userID != 0
                    else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "SegueLaunchToSignIn", sender: self)
                }
                return
            }

            KeyStore.shared.accessToken = resp?.accessToken
            KeyStore.shared.refreshToken = resp?.refreshToken
            KeyStore.shared.userId = resp?.userID
            KeyStore.shared.expiresIn = resp?.expiresIn

            DispatchQueue.main.async {
                self.parent?.performSegue(withIdentifier: "SegueLaunchToRootWithoutAnimation", sender: self)
            }
        })
    }
}
