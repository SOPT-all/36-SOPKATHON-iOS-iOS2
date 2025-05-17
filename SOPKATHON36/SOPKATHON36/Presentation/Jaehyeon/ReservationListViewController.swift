//
//  ReservationListViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit
import SnapKit
import Then



class ReservationListViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_b_24, text: "예약내역")
        $0.textColor = .black
    }

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo1")
        $0.contentMode = .scaleAspectFit
    }

    private let doLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_m_14, text: "총 2번의 UP사이클링을 실천했어요!")
        $0.textColor = .black
    }

    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(ReservationListTableViewCell.self, forCellReuseIdentifier: ReservationListTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayScale000
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }


        let headerView = UIView()
        headerView.addSubviews(titleLabel, logoImageView, doLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120)
        }

        doLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }


        let width = UIScreen.main.bounds.width
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: 180)
        headerView.layoutIfNeeded()
        

        let fittingSize = headerView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        headerView.frame.size.height = fittingSize.height
        

        tableView.tableHeaderView = headerView
    }
}

extension ReservationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReservationListTableViewCell.reuseIdentifier, for: indexPath) as? ReservationListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: "2025.05.17 / 00:00")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
