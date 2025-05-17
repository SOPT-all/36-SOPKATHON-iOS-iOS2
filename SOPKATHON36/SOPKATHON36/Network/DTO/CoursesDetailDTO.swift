//
//  CoursesDetailRequestDTO.swift
//  SOPKATHON36
//
//  Created by LEESOOYONG on 5/18/25.
//

import Foundation

struct CoursesDetailRequestDTO: Codable {
    let phoneNumber: String
}

struct CoursesDetailDTO {
    let id: Int
    let shop: ShopList
    let schedules: [Schedule]
}

struct Schedule {
    let id: Int
    let time: String
}

struct ShopList {
    let id: Int
    let location, businessHour, phoneNumber: String
}
