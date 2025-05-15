//
//  ReuseIdentifiable.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import Foundation

/// 재사용 셀, 뷰에 채택하여 식별자 명시를 생략할 수 있는 프로토콜입니다
protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
