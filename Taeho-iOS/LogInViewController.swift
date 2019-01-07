//
//  LogInViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/5/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift

class LogInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorMessagesLabel: UILabel!

    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds

        emailText.becomeFirstResponder()

        Auth.shared.logInCallback
            .debug("logInCallBack")
            .subscribe(onNext: {(resp, result) in
                DispatchQueue.main.async {
                    defer {
                        self.activityIndicator.stopAnimating()
                    }

                    guard result.statusCode == .ok else {
                        self.errorMessagesLabel.text = result.statusMessage
                        self.errorMessagesLabel.sizeToFit()
                        return
                    }

                    self.performSegue(withIdentifier: "SegueLogInToRoot", sender: self)
                }
            })
            .disposed(by: disposeBag)
    }

    @IBAction func logInButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorMessagesLabel.text = nil

        var logInRequest = User_LogInRequest()
        logInRequest.userType = .email
        logInRequest.email = emailText.text ?? ""
        logInRequest.password = passwordText.text ?? ""

        Auth.shared.logInStream.onNext(logInRequest)
    }

}
