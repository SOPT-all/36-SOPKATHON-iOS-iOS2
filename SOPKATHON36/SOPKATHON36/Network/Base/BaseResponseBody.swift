//
//  BaseResponseBody.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import Foundation

struct BaseResponseBody<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
}
