//
//  SignUpViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var errorMessagesLabel: UILabel!
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    let userClient = GrpcClient.userClient


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds

        emailText.becomeFirstResponder()
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorMessagesLabel.text = nil

        var registerRequest = User_RegisterRequest()
        registerRequest.userType = .email
        registerRequest.email = emailText.text ?? ""
        registerRequest.password = passwordText.text ?? ""
        registerRequest.name = nameText.text ?? ""

        _ = try? userClient.register(registerRequest, completion: { (resp, result) in
            DispatchQueue.main.async {
                defer {
                    self.activityIndicator.stopAnimating()
                }

                guard result.statusCode == .ok else {
                    self.errorMessagesLabel.text = result.statusMessage
                    self.errorMessagesLabel.sizeToFit()
                    return
                }
                guard let refreshToken: String = resp?.refreshToken else {
                    return
                }

                Auth.shared.refreshToken = refreshToken
                self.performSegue(withIdentifier: "SegueSignUpToRoot", sender: self)
            }
        })
    }

}
