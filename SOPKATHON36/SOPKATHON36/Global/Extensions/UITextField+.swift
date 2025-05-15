//
//  UITextField+.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import UIKit

extension UITextField {
    /// 기본 textField를 설정하는 함수입니다
    func configureDefaultTextField() {
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.autocapitalizationType = .none
        self.clearsOnBeginEditing = false
    }
    
    /// 좌, 우 Padding을 추가하는 함수입니다
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
    
    /// placeholder의 색상을 바꾸는 함수입니다
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
