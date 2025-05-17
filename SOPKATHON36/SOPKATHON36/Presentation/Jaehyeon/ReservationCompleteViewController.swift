//
//  ReservationCompleteViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit

class ReservationCompleteViewController: UIViewController {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_success")
        $0.contentMode = .scaleAspectFit
    }
    
    private let onedayLabel = UIButton().then {
        $0.setTitle("폐 로프 바구니", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .brand1
        $0.setCornerRadius(12)
        }

    
    private let titleLabel = UILabel().then {
            $0.attributedText = .pretendard(.title_b_24, text: "예약이 완료되었습니다!")
        }
    
//    private let materialLabel = UILabel().then {
//        $0.attributedText = .pretendard(.title_m_16, text: "반지")
//        $0.backgroundColor = .lightGray
//        }
    
    private let numberPeople = UIButton().then {
        $0.setTitle("1명", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 14)
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.setCornerRadius(4)
        $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
    
    
    private let dateLabel = UIButton().then {
        $0.setTitle("2025년 12월 18일", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 14)
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.setCornerRadius(4)
        $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
    
    private let timeLabel = UIButton().then {
        $0.setTitle("04시 52분", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 14)
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.setCornerRadius(4)
        $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
    
    
    
    private let returnButton = UIButton().then {
        $0.setTitle("홈으로 돌아가기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = .black
        $0.setCornerRadius(12)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayScale000
        setupUI()

        returnButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.view.addSubviews(logoImageView,onedayLabel,titleLabel,numberPeople,dateLabel,timeLabel,returnButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(374)
     
        
        }
        
        onedayLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalTo(logoImageView.snp.centerX)
            $0.width.equalTo(127)
            $0.height.equalTo(28)
            
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(onedayLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(logoImageView.snp.centerX)
        }
        

        numberPeople.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(numberPeople.snp.bottom).offset(8)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom).offset(70)
            $0.height.equalTo(50)
        }
    
    }

}

extension ReservationCompleteViewController {
    @objc
    private func completeButtonDidTap() {
        navigationController?.popToRootViewController(animated: true)
    }
}
