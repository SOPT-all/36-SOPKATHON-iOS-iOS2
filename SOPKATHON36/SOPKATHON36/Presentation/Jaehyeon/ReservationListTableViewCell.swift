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
        $0.backgroundColor = .yellow
        $0.layer.masksToBounds = true
        
    }

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "pencil")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
    }

    private let titleLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "작업장 1")
        $0.textColor = .black
        
    }

    private let dateLabel = UILabel().then {
        $0.attributedText = .pretendard(.label_r_12, text: "2025.05.18")
        $0.textColor = .black
        $0.backgroundColor = .lightGray
    }

    private let timeLabel = UILabel().then {
        $0.attributedText = .pretendard(.label_r_12, text: "오전 12시")
        $0.textColor = .black
        $0.backgroundColor = .lightGray
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

        contentContainerView.addSubviews(logoImageView, titleLabel, dateLabel, timeLabel)

        logoImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.top.equalTo(logoImageView.snp.top).offset(4)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(12)
            $0.centerY.equalTo(dateLabel)
        }
    }
}
