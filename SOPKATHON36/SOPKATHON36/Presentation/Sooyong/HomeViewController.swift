//
//  HomeViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit

import Then
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var filterButtons: [FilterButton] = []
    
    // MARK: - UI Properties
    
    private let headerContainerView = UIView()
    
    private let nameLabel = UILabel()
    
    private let upCycleLabel = UILabel()
    
    private let tableView = UITableView()
    
    private let shipImageView = UIImageView()
    
    private let separatorView = UIView()
    
    private let allButton = FilterButton(.all, isSelected: true)
    
    private let accessoriesButton = FilterButton(.accessories, isSelected: false)
    
    private let lifeButton = FilterButton(.life, isSelected: false)
    
    private let goodsButton = FilterButton(.goods, isSelected: false)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFilterButtons()
        setStyle()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setStyle() {
        headerContainerView.do {
            $0.backgroundColor = .grayScale050
        }
        
        tableView.do {
            $0.backgroundColor = .grayScale050
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
        
        nameLabel.do {
            $0.attributedText = .pretendard(.title_b_24, text: "9427님")
        }
        
        upCycleLabel.do {
            $0.attributedText = .pretendard(.title_b_24, text: "오늘은 어떤 UP사이클을 할까요?")
        }
        
        shipImageView.do {
            $0.image = .ship1 // 기본이 1
            $0.contentMode = .scaleAspectFit
        }
        
        separatorView.do {
            $0.backgroundColor = .grayScale200
        }
        
        allButton.tag = 0
        accessoriesButton.tag = 1
        lifeButton.tag = 2
        goodsButton.tag = 3
    }
    
    private func setUI() {
        view.addSubviews(headerContainerView, tableView)
        
        headerContainerView.addSubviews(
            nameLabel,
            upCycleLabel,
            shipImageView,
            separatorView,
            allButton,
            accessoriesButton,
            lifeButton,
            goodsButton
        )
    }
    
    private func setLayout() {
        headerContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(450)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.equalTo(16)
        }
        
        upCycleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(-8)
            $0.leading.equalTo(16)
        }
        
        shipImageView.snp.makeConstraints {
            $0.top.equalTo(upCycleLabel.snp.bottom).offset(22)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(197)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(shipImageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        allButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(separatorView).offset(22)
            $0.width.equalTo(49)
        }
        
        accessoriesButton.snp.makeConstraints {
            $0.leading.equalTo(allButton.snp.trailing).offset(6)
            $0.top.equalTo(separatorView).offset(22)
            $0.width.equalTo(70)
        }
        
        lifeButton.snp.makeConstraints {
            $0.leading.equalTo(accessoriesButton.snp.trailing).offset(6)
            $0.top.equalTo(separatorView).offset(22)
            $0.width.equalTo(70)
        }
        
        goodsButton.snp.makeConstraints {
            $0.leading.equalTo(lifeButton.snp.trailing).offset(6)
            $0.top.equalTo(separatorView).offset(22)
            $0.width.equalTo(70)
        }
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setRegister() {
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifier)
    }
    
    private func setAction() {
        allButton.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        accessoriesButton.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        lifeButton.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        goodsButton.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
    }
}

// MARK: - Functions

extension HomeViewController {
    @objc
    private func filterButtonDidTap(_ sender: UIButton) {
        for button in filterButtons {
            let isSelected = (button == sender)
            button.isSelected = isSelected
        }
    }
    
    private func setFilterButtons() {
        [allButton, accessoriesButton, lifeButton, goodsButton].forEach { button in
            filterButtons.append(button)
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

// MARK: - HomeCellDelegate

extension HomeViewController: HomeCellDelegate {
    func leftButtonDidTap() {
        let viewController = ReservationViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
