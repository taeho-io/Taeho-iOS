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
import RxKeyboard
import Then

class NoteEditViewController: UIViewController {

    let disposeBag = DisposeBag()

    let noteTextView = UITextView(frame: .zero).then {
        $0.alwaysBounceVertical = true
        $0.keyboardDismissMode = .interactive
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 16)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.hidesBarsOnSwipe = true

        noteTextView.frame = view.frame
        self.view.addSubview(self.noteTextView)

        RxKeyboard.instance.visibleHeight
          .drive(onNext: { [weak self] keyboardVisibleHeight in
              self?.view.setNeedsLayout()
              UIView.animate(withDuration: 0) {
                  self?.noteTextView.contentInset.bottom = keyboardVisibleHeight
                  self?.noteTextView.scrollIndicatorInsets.bottom = (self?.noteTextView.contentInset.bottom)!
                  self?.view.layoutIfNeeded()
              }
          })
            .disposed(by: self.disposeBag)

        noteTextView.rx.text.subscribe(onNext: { noteText in
            print(noteText)
        })
        .disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if self.noteTextView.contentInset.bottom == 0 {
            self.noteTextView.contentInset.bottom = 0
            self.noteTextView.scrollIndicatorInsets.bottom = self.noteTextView.contentInset.bottom
        }
    }
}
