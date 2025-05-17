//
//  NSAttributedString+.swift
//  SOPKATHON36
//
//  Created by 임재현 on 5/17/25.
//

import UIKit
extension NSAttributedString {
    static func pretendard(_ style: UIFont.PretendardStyle, text: String) -> NSAttributedString {
        let font = UIFont.pretendard(style)
        let paragraph = NSMutableParagraphStyle()
        let lineHeight: CGFloat
        let kern: CGFloat = -1

        switch style {
        case .title_b_24, .title_sb_24:
            lineHeight = 36
        case .title_sb_20, .body_m_20:
            lineHeight = 30
        case .title_sb_16, .title_m_16, .body_r_16:
            lineHeight = 24
        case .title_m_14, .body_r_14:
            lineHeight = 20
        case .label_sb_12, .label_r_12:
            lineHeight = 12
        }


        let lineHeightMultiple = lineHeight / font.lineHeight
        let baselineOffset = (lineHeight - font.lineHeight)
        paragraph.lineHeightMultiple = lineHeightMultiple
        paragraph.alignment = .natural

        return NSAttributedString(string: text, attributes: [
            .font: font,
            .kern: kern,
            .paragraphStyle: paragraph,
            .baselineOffset: baselineOffset
        ])
    }
}

