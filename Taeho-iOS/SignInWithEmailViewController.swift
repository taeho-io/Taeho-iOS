//
//  LogInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import SwiftGRPC
import GoogleSignIn

class SignInWithEmailViewController: UIActivityIndicatorViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessagesLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.becomeFirstResponder()
    }

    @IBAction func logInButtonPressed(_ sender: Any) {
        showActivityIndicator()
        errorMessagesLabel.text = nil

        var logInRequest = User_LogInRequest()
        logInRequest.userType = .email
        logInRequest.email = emailText.text ?? ""
        logInRequest.password = passwordText.text ?? ""

        userClient.metadata = Metadata()
        _ = try? userClient.logIn(logInRequest, completion: { (resp, result) in
            defer {
                self.hideActivityIndicator()
            }

            guard result.statusCode == .ok,
                  let resp: User_LogInResponse = resp
                    else {
                DispatchQueue.main.async {
                    self.errorMessagesLabel.text = result.statusMessage
                    self.errorMessagesLabel.sizeToFit()
                }
                return
            }

            Auth.shared.updateUserTokenInfo(
                    accessToken: resp.accessToken,
                    refreshToken: resp.refreshToken,
                    userId: resp.userID,
                    expiresIn: resp.expiresIn)

            DispatchQueue.main.async {
                self.parent?.performSegue(withIdentifier: "SegueLaunchToRoot", sender: self)
            }
        })
    }

}
