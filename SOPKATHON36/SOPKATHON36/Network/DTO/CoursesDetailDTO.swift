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

struct CoursesDetailResponseDTO: Codable {
    let id: Int
    let shop: ShopList
    let schedules: [Schedule]
}

struct Schedule: Codable {
    let id: Int
    let time: String
}

struct ShopList: Codable {
    let id: Int
    let location, businessHour, phoneNumber: String
}
