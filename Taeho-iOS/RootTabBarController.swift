//
//  RootTabBarController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/26/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift

class RootTabBarController: UITabBarController {

    let disposeBag = DisposeBag()


    func subscribeSignOutStream() {
        Auth.shared.signOutStream
            .take(1)
            .subscribe(onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeSignOutStream()
    }

}
