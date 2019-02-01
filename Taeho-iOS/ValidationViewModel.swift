//
// Created by Taeho Kim on 2019-01-31.
// Copyright (c) 2019 taeho.io. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ValidationViewModel {

    var errorMessage: String { get }

    // Observables
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get }

    // Validation
    func validate() -> Bool
}

class PasswordViewModel: ValidationViewModel {

    var errorMessage: String = "Please enter a valid Password"

    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")

    func validate() -> Bool {
        guard validateLength(text: data.value, min: 6) else {
            errorValue.accept(errorMessage)
            return false;
        }

        errorValue.accept("")
        return true
    }

    func validateLength(text: String, min: Int) -> Bool {
        return text.count >= min
    }
}

class EmailViewModel: ValidationViewModel {

    var errorMessage: String = "Please enter a valid Email"

    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")

    func validate() -> Bool {
        guard validatePattern(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }

        errorValue.accept("")
        return true
    }

    func validatePattern(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
