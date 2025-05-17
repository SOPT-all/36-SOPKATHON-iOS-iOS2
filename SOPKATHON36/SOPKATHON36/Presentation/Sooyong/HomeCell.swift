//
//  HomeCell.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/18/25.
//

import UIKit

import SnapKit
import Then

protocol HomeCellDelegate: AnyObject {
    func leftButtonDidTap()
}

class HomeCell: UITableViewCell, ReuseIdentifiable {
    
    // MARK: - UI Properties
    
    weak var delegate: HomeCellDelegate?
    
    private let containerView = UIView()
    
    private let mainImageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let subTitleLabel = UILabel()
    
    private let leftButton = UIButton()
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setting
    
    private func setStyle() {
        self.do {
            $0.selectionStyle = .none
        }
        
        contentView.do {
            $0.backgroundColor = .grayScale050
        }
        
        containerView.do {
            $0.backgroundColor = .grayScale000
            $0.setCornerRadius(8)
        }
        
        mainImageView.do {
            $0.setCornerRadius(8)
            $0.image = .img11
            $0.backgroundColor = .grayScale200
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.attributedText = .pretendard(.title_m_14, text: "폐 로프 바구니")
            $0.textColor = .grayScale800
        }
        
        subTitleLabel.do {
            $0.attributedText = .pretendard(.label_r_12, text: "수납 가능한 감성 로프 바구니 만들기")
            $0.textColor = .grayScale600
        }
        
        leftButton.do {
            $0.setImage(.arrowRight, for: .normal)
        }
    }
    
    private func setUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubviews(mainImageView, titleLabel, subTitleLabel, leftButton)
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(72)
        }
        
        mainImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        leftButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setAction() {
        leftButton.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func leftButtonDidTap() {
        delegate?.leftButtonDidTap() // 데이터 전달
        print("Asef")
    }
}
