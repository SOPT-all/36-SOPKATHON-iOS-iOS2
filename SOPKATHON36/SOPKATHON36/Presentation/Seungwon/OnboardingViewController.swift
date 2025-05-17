//
//  OnboardingViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/18/25.
//

import UIKit

import Then
import SnapKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let numberLabel = UILabel()
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - UI Setting
    
    private func setStyle() {
        view.do {
            $0.backgroundColor = .grayScale050
        }
        
        numberLabel.do {
            $0.backgroundColor = .brand4
            $0.textColor = .brand1
            $0.attributedText = .pretendard(.title_m_14, text: "9427님")
            $0.textAlignment = .center
            $0.setCornerRadius(8)
        }
        
        imageView.do {
            $0.image = .onboarding
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.attributedText = .pretendard(.title_sb_20, text: "UP사이클 할 준비가 완료됐어요!")
            $0.textColor = .grayScale900
        }
    }
    
    private func setUI() {
        view.addSubviews(numberLabel, imageView, titleLabel)
    }
    
    private func setLayout() {
        numberLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(247)
            $0.height.equalTo(36)
            $0.width.equalTo(76)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(50)
            $0.width.equalTo(186)
            $0.height.equalTo(126)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Functions

extension OnboardingViewController {
    @objc
    private func nextButtonDidTap() {
        print(#function)
    }
}
