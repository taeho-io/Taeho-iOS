//
//  NoteEditViewController.swift
//  Taeho-iOS
//
//  Created by Taeho Kim on 1/27/19.
//  Copyright © 2019 taeho.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoteEditViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var noteTextView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.hidesBarsOnSwipe = true

        noteTextView.isUserInteractionEnabled = true
        noteTextView.keyboardDismissMode = .onDrag

        noteTextView.rx.text.subscribe(onNext: { noteText in
            print(noteText)
        })
        .disposed(by: disposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        noteTextView.endEditing(true)
    }

}
