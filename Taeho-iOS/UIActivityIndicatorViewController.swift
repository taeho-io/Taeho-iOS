//
//  UIActivityIndicatorViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/9/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit

class UIActivityIndicatorViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView(style: .gray)


    func initActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }

    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityIndicator()
    }

}
