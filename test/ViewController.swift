//
//  ViewController.swift
//  test
//
//  Created by 김종권 on 2020/10/17.
//  Copyright © 2020 jongkwon kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class ViewController: UIViewController {

    @IBOutlet weak var constraintBottom: NSLayoutConstraint!

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }

    func binding() {
        keybordHeightChangedEvent()
    }

    private func keybordHeightChangedEvent() {
        RxKeyboard.instance.visibleHeight
            .drive(rx.keyboardHeightChanged)
            .disposed(by: bag)
    }
}


extension Reactive where Base: ViewController {

    var keyboardHeightChanged: Binder<CGFloat> {
        return Binder(base) { vc, height in
            UIView.animate(withDuration: 0.2, animations: {
                let safeAreaBottom = vc.view.safeAreaInsets.bottom
                vc.constraintBottom.constant = height - safeAreaBottom + 16
                vc.view.layoutIfNeeded()
            })
        }
    }
}
