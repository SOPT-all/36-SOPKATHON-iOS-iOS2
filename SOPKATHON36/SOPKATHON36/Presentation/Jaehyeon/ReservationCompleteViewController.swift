//
//  ReservationCompleteViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit

class ReservationCompleteViewController: UIViewController {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "pencil")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
    }
    
    private let titleLabel = UILabel().then {
            $0.attributedText = .pretendard(.title_b_24, text: "예약이 완료되었습니다!")
        }
    
    private let materialLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_m_16, text: "반지")
        $0.backgroundColor = .lightGray
        }
    
    private let numberPeople = UILabel().then {
            $0.attributedText = .pretendard(.title_m_16, text: "1명")
        }
    private let dateLabel = UILabel().then {
            $0.attributedText = .pretendard(.title_m_16, text: "2025년 5월 30일")
        }
    
    private let returnButton = UIButton().then {
        $0.setTitle("홈으로 돌아가기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = .black
        $0.setCornerRadius(12)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI() {
        self.view.addSubviews(logoImageView,titleLabel,materialLabel,numberPeople,dateLabel,returnButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.size.equalTo(226)
            $0.centerX.equalToSuperview()
        
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalTo(logoImageView.snp.centerX)
        }
        
        materialLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(titleLabel.snp.centerX)
            
        }
        
        numberPeople.snp.makeConstraints {
            $0.top.equalTo(materialLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(numberPeople.snp.bottom).offset(2)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom).offset(70)
            $0.height.equalTo(50)
        }
    
    }

}
