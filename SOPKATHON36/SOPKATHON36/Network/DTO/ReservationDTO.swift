//
//  ReservationDTO.swift
//  SOPKATHON36
//
//  Created by LEESOOYONG on 5/18/25.
//

import Foundation

struct ReservationRequestDTO: Codable {
    let phoneNumber: String
}

struct ReservationResponseDTO: Codable {
    let number_of_people: Int
}
