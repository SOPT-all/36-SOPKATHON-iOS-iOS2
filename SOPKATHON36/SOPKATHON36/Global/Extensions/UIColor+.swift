//
//  UIColor+.swift
//  SOPKATHON36
//
//  Created by hyunwoo on 5/17/25.
//

import UIKit

enum SopkathonColor: String {
    
    case grayscale000 = "GrayScale000"
    case grayscale050 = "GrayScale050"
    case grayscale100 = "GrayScale100"
    case grayscale200 = "GrayScale200"
    case grayscale300 = "GrayScale300"
    case grayscale400 = "GrayScale400"
    case grayscale500 = "GrayScale500"
    case grayscale600 = "GrayScale600"
    case grayscale700 = "GrayScale700"
    case grayscale800 = "GrayScale800"
    case grayscale900 = "GrayScale900"
    case grayscale999 = "GrayScale999"
    
}

extension UIColor {
    static func color(_ color: SopkathonColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? .clear
    }
}
