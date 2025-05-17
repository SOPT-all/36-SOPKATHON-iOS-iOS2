//
//  LoginDTO.swift
//  SOPKATHON36
//
//  Created by LEESOOYONG on 5/18/25.
//

import Foundation

struct LoginRequestDTO: Codable {
    let phoneNumber: String
}

struct LoginResponseDTO: Codable {
    let message: String
}
