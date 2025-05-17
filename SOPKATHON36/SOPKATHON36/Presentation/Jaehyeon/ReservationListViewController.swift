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
    
    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(ReservationListTableViewCell.self, forCellReuseIdentifier: ReservationListTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubviews(titleLabel,tableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

  
}

extension ReservationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReservationListTableViewCell.reuseIdentifier, for: indexPath) as? ReservationListTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88  
    }

}



