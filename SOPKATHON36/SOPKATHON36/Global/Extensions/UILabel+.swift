//
//  UILabel+.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import UIKit

extension UILabel {
    /// UILabel에 밑줄을 추가하는 함수입니다
    func addUnderline() {
        guard let labelText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
    }
}

