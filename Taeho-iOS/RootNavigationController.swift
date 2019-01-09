//
//  RootNavigationController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/6/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootNavigationController: UINavigationController {

    let disposeBag = DisposeBag()


    func subscribeSignOutStream() {
        Auth.shared.signOutStream
            .debug("subscribeSignOutStream")
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
