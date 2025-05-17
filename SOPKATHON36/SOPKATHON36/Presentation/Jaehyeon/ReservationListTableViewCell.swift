//
//  ReservationListTableViewCell.swift
//  SOPKATHON36
//
//  Created by 임재현 on 5/17/25.
//

import UIKit
import SnapKit
import Then


class ReservationListTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    private let contentContainerView = UIView().then {
        $0.backgroundColor = .grayScale050
        $0.layer.masksToBounds = true
        $0.setCornerRadius(8)
        
    }

    private let logoImageView = UIImageView().then {
        $0.image = .img11
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setCornerRadius(8)
        
//        $0.backgroundColor = .red
    }

    private let titleLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "폐 로프 바구니")
        $0.textColor = .black
        
    }
    
    private let subTitleLabel = UILabel().then {
        $0.attributedText = .pretendard(.label_r_12, text: "업체명1")
        $0.textColor = .lightGray
    }

    private let dateAndTimeLabel = UILabel().then {
        $0.attributedText = .pretendard(.label_r_12, text: "2025.05.18 / 00:00")
        $0.textColor = .lightGray
    }

   

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
        }

        contentContainerView.addSubviews(logoImageView, titleLabel, dateAndTimeLabel, subTitleLabel)

        logoImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.top.equalTo(logoImageView.snp.top).offset(4)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }

        dateAndTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(subTitleLabel.snp.leading)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
        }

       
    }
    
    func configure(with dateString: String) {
        dateAndTimeLabel.attributedText = .pretendard(.label_r_12, text: dateString)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd / HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")

        guard let reservationDate = formatter.date(from: dateString) else {
            // 파싱 실패 시 기본 회색 유지
            dateAndTimeLabel.textColor = .lightGray
            return
        }

        let now = Date()
        if reservationDate > now {
            // 아직 안 지난 예약 → 파란색
            dateAndTimeLabel.textColor = .blue
        } else {
            // 지난 예약 → 회색
            dateAndTimeLabel.textColor = .lightGray
        }
    }

}
