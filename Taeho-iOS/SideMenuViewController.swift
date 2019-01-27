//
//  SideMenuViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/27/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notesButtonPressed(_ sender: Any) {
        if let tabBar: RootTabBarController = RootTabBarController.rootTabBarController {
            tabBar.selectedIndex = 0
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        if let tabBar: RootTabBarController = RootTabBarController.rootTabBarController {
            tabBar.selectedIndex = 1
        }
        dismiss(animated: true, completion: nil)
    }

}
