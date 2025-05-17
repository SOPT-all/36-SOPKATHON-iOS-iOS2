//
//  ReservationListDTO.swift
//  SOPKATHON36
//
//  Created by LEESOOYONG on 5/18/25.
//

import Foundation

struct ReservationListRequestDTO: Codable {
    let phoneNumber: String
}


struct ReservationDTO: Codable {
    let reservations: [Reservation]
}

struct Reservation: Codable {
    let id: Int
    let image, title: String
    let shop: [Shop]
    let time: String
}

struct Shop: Codable {
    let id: Int
    let name: String
}
