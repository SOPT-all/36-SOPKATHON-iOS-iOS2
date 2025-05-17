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
    
    var number: String = ""

    
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
            $0.attributedText = .pretendard(.title_b_24, text: "\(number.suffix(4))님")
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

        switch sender {
        case allButton:
            shipImageView.image = UIImage(named: "ship5")

        case accessoriesButton:
            shipImageView.image = UIImage(named: "ship2")

        case lifeButton:
            shipImageView.image = UIImage(named: "ship3")

        case goodsButton:
            shipImageView.image = UIImage(named: "ship4")

        default:
            break
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

// MARK: - model

struct Course1: Identifiable {
    let id: Int
    let image: String
    let title: String
    let description: String
    let ingredient: String
}

let mockCourses: [Course1] = [
    Course1(id: 1, image: "https://example.com/image1.jpg", title: "폐목재 액자 프레임", description: "조선소 목재로 만드는 프레임", ingredient: "나무"),
    Course1(id: 2, image: "https://example.com/image2.jpg", title: "업사이클링 키링 만들기", description: "버려진 플라스틱으로 만드는 키링", ingredient: "플라스틱"),
    Course1(id: 3, image: "https://example.com/image3.jpg", title: "유리 조각 테라리움", description: "폐유리 조각으로 만드는 식물 인테리어", ingredient: "유리"),
    Course1(id: 4, image: "https://example.com/image4.jpg", title: "타이어 의자 제작", description: "폐타이어로 만드는 DIY 의자", ingredient: "고무"),
    Course1(id: 5, image: "https://example.com/image5.jpg", title: "헌옷 쿠션 만들기", description: "헌 옷감을 재활용한 소파 쿠션", ingredient: "천"),
    Course1(id: 6, image: "https://example.com/image6.jpg", title: "폐CD 벽장식 만들기", description: "폐CD로 반짝이는 벽장식 완성", ingredient: "플라스틱"),
    Course1(id: 7, image: "https://example.com/image7.jpg", title: "업사이클 노트 제작", description: "재생지와 폐종이로 만든 노트", ingredient: "종이"),
    Course1(id: 8, image: "https://example.com/image8.jpg", title: "유리병 화병 만들기", description: "버려진 유리병의 변신", ingredient: "유리"),
    Course1(id: 9, image: "https://example.com/image9.jpg", title: "와이어 아트 액자", description: "폐전선으로 만드는 벽 액자", ingredient: "금속"),
    Course1(id: 10, image: "https://example.com/image10.jpg", title: "폐목재 벤치 만들기", description: "조선소에서 나온 나무로 벤치 만들기", ingredient: "나무"),
    Course1(id: 11, image: "https://example.com/image11.jpg", title: "플라스틱 화분 제작", description: "폐플라스틱을 녹여 만든 작은 화분", ingredient: "플라스틱"),
    Course1(id: 12, image: "https://example.com/image12.jpg", title: "캔들홀더 만들기", description: "유리 조각으로 만든 감성 캔들홀더", ingredient: "유리"),
    Course1(id: 13, image: "https://example.com/image13.jpg", title: "바다유리 목걸이", description: "해변에서 주운 바다유리로 목걸이 제작", ingredient: "유리"),
    Course1(id: 14, image: "https://example.com/image14.jpg", title: "헌책 북아트", description: "헌책을 활용한 아트북 만들기", ingredient: "종이"),
    Course1(id: 15, image: "https://example.com/image15.jpg", title: "폐천 텀블러 파우치", description: "버려진 커튼 원단으로 파우치 만들기", ingredient: "천")
]
