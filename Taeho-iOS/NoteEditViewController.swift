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

class Note {

    var note: Note_NoteMessage?

    private init() {}

    private static var sharedNote: Note = {
        let note = Note()
        return note
    }()

    class var shared: Note {
        return sharedNote
    }

}

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
            if var note = Note.shared.note, let noteText = noteText {
                note.body = noteText
            }
        })
        .disposed(by: disposeBag)

        if let note = Note.shared.note {
            noteTextView.text = note.body
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if self.noteTextView.contentInset.bottom == 0 {
            self.noteTextView.contentInset.bottom = 0
            self.noteTextView.scrollIndicatorInsets.bottom = self.noteTextView.contentInset.bottom
        }
    }
}
