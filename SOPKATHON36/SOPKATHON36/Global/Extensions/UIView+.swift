//
//  UIView+.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import UIKit

extension UIView {
    /// addSubview의 복수형 함수입니다
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    /// cornerRadius를 설정하는 함수입니다
    func setCornerRadius(
        _ cornerRadius: CGFloat,
        maskedCorners: CACornerMask = [
            .layerMaxXMaxYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]
    ) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    /// border를 설정하는 함수입니다
    /// 기본 width는 1입니다
    func setBorder(_ borderWidth: CGFloat = 1, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}

/// alert를 설정하는 함수입니다
extension UIViewController {
    func showAlert(title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "확인", style: .default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}

