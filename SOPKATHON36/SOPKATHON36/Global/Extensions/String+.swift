//
//  String+.swift
//  SOPKATHON36
//
//  Created by 임재현 on 5/17/25.
//

import Foundation

extension String {
    /// 하이픈이 포함되거나 포함되지 않은 한국 전화번호 형식을 검증합니다.
    var isValidPhoneNumber: Bool {
        let pattern = #"^01[0|1|6|7|8|9]-?\d{3,4}-?\d{4}$"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
}
