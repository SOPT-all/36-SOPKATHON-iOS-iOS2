//
//  CoursesDTO.swift
//  SOPKATHON36
//
//  Created by LEESOOYONG on 5/18/25.
//

import Foundation

struct CoursesRequestDTO: Codable {
    let phoneNumber: String
}

struct CoursesDTO {
    let courses: [Course]
}

struct Course: Codable {
    let id: Int
    let image: String
    let productName, description, ingredient: String
}
