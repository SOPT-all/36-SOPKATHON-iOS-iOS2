//
//  UIViewController+.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import UIKit

extension UIViewController {
    /// 화면 터치시 키보드를 내리는 함수입니다
    ///
    /// 화면 외 다른 컴포넌트(버튼)을 눌렀을 때 내려가지 않게 하고 싶은 경우 cancelsTouchesInView를 true로 설정합니다.
    func hideKeyboardWhenDidTap(cancelsTouches cancelsTouchesInView : Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

