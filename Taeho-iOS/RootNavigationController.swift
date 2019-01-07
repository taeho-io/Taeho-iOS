//
//  RootNavigationController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/6/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        try? Auth.shared.refreshAccessToken()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
