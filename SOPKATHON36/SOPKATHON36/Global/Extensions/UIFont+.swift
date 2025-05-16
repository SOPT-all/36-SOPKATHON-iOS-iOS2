//
//  UIFont+.swift
//  SOPKATHON36
//
//  Created by 임재현 on 5/17/25.
//

import UIKit

extension UIFont {

    enum Family: String {
        case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, Semibold, Thin
    }

    static func pretendard(weight: Family = .Regular, size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Pretendard-\(weight.rawValue)", size: size) {
            return font
        } else {
            print("Pretendard-\(weight.rawValue) loading failed, fallback to system font")
            return .systemFont(ofSize: size)
        }
    }

    enum PretendardStyle {
        case title_b_24
        case title_sb_24
        case title_sb_20
        case title_sb_16
        case title_m_16
        case title_m_14
        case body_m_20
        case body_r_16
        case body_r_14
        case label_sb_12
        case label_r_12
    }

    static func pretendard(_ style: PretendardStyle) -> UIFont {
        switch style {
        case .title_b_24: return .pretendard(weight: .Bold, size: 24)
        case .title_sb_24: return .pretendard(weight: .Semibold, size: 24)
        case .title_sb_20: return .pretendard(weight: .Semibold, size: 20)
        case .title_sb_16: return .pretendard(weight: .Semibold, size: 16)
        case .title_m_16: return .pretendard(weight: .Medium, size: 16)
        case .title_m_14: return .pretendard(weight: .Medium, size: 14)
        case .body_m_20: return .pretendard(weight: .Medium, size: 20)
        case .body_r_16: return .pretendard(weight: .Regular, size: 16)
        case .body_r_14: return .pretendard(weight: .Regular, size: 14)
        case .label_sb_12: return .pretendard(weight: .Semibold, size: 12)
        case .label_r_12: return .pretendard(weight: .Regular, size: 12)
        }
    }
}
