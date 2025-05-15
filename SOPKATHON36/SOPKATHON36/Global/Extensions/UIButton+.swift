//
//  UIButton+.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import UIKit

extension UIButton {
    /// 버튼 title에 밑줄을 추가하는 함수입니다
    func addUnderline() {
        let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}

