//
//  ReservationViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//
import UIKit

import SnapKit
import Then

class ReservationViewController: UIViewController, UITextFieldDelegate {
    
    private var filterButton : [UIButton] = []
    private var memberIsSelected : Bool = false {
        didSet {
            activeReservation()
        }
    }
    
    private var reservationIsSelected : Bool = false {
        didSet {
            activeReservation()
        }
    }
    
    private var timeIsSelected : Bool = false {
        didSet {
            activeReservation()
        }
    }
    
    let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let mainImageView = UIImageView().then {
        $0.backgroundColor = .red
        $0.isUserInteractionEnabled = true
    }
    
    let backButton = UIButton().then {
        $0.setImage(.headerLeft, for: .normal)
    }
    
    let classLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_24, text: "원데이 클래스")
        $0.textColor = .grayScale800
    }
    
    let shopLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_m_16, text: "매장 이름")
        $0.textColor = .grayScale600
    }
    
    let spotImageView = UIImageView().then {
        $0.image = .spot
        $0.contentMode = .scaleAspectFit
    }
    
    let spotLabel = UILabel().then {
        $0.attributedText = .pretendard(.body_r_14, text: "주소를 입력해주세요.")
        $0.textColor = .grayScale600
    }
    
    let timeLabel = UILabel().then {
        $0.attributedText = .pretendard(.body_r_14, text: "영업시간을 입력해주세요.")
        $0.textColor = .grayScale600
    }
    
    let callLabel = UILabel().then {
        $0.attributedText = .pretendard(.body_r_14, text: "전화번호를 입력해주세요.")
        $0.textColor = .grayScale600
    }
    
    let timeImageView = UIImageView().then {
        $0.image = .time
        $0.contentMode = .scaleAspectFit
    }
    
    let callImageView = UIImageView().then {
        $0.image = .call
        $0.contentMode = .scaleAspectFit
    }
    
    let dividerView = UIView().then {
        $0.backgroundColor = .grayScale100
    }
    
    let personLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "예약 인원")
        $0.textColor = .grayScale999
    }
    
    let personButton1 = UIButton(type: .system).then {
        $0.setTitle("1", for: .normal)
        $0.layer.cornerRadius = 4
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.tag = 1
    }
    
    let personButton2 = UIButton(type: .system).then {
        $0.setTitle("2", for: .normal)
        $0.layer.cornerRadius = 4
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.tag = 2
    }
    
    let personButton3 = UIButton(type: .system).then {
        $0.setTitle("3", for: .normal)
        $0.layer.cornerRadius = 4
        $0.setTitleColor(.grayScale600, for: .normal)
        $0.backgroundColor = .grayScale200
        $0.tag = 3
    }
    
    let DateLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "예약 날짜")
        $0.textColor = .grayScale999
    }
    
    let DateTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .pretendard(.title_m_14)
        $0.backgroundColor = .grayScale200
        $0.borderStyle = .roundedRect
        $0.placeholder = "날짜 선택"
    }
    
    let TimeLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "시간 선택")
        $0.textColor = .grayScale999
    }
    
    let TimeTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .pretendard(.title_m_14)
        $0.backgroundColor = .grayScale200
        $0.borderStyle = .roundedRect
        $0.placeholder = "시간 선택"
    }
    
    let reserveButton = UIButton().then{
        $0.setTitle("예약하기", for: .normal)
        $0.titleLabel?.attributedText = .pretendard(.title_sb_16, text: "예약 시간")
        $0.layer.cornerRadius = 4
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .grayScale300
        $0.setTitleColor(.grayScale000, for: .normal)
        $0.isEnabled = false
    }
    
    let datepicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setLayout()
        setFilterButton()
        
        DateTxt.delegate = self
        TimeTxt.delegate = self
        
        datepicker.locale = Locale(identifier: "ko-KR")
        datepicker.preferredDatePickerStyle = .inline
        datepicker.minimumDate = Date()
        
        navigationController?.navigationBar.isHidden = true
        
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        personButton1.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        personButton2.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        personButton3.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        reserveButton.addTarget(self, action: #selector(reservationButtonDidTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func createDatePicker(mode: UIDatePicker.Mode, inputField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(donePressed)
        )
        toolbar.setItems([doneButton], animated: true)
        
        inputField.inputView = datepicker
        inputField.inputAccessoryView = toolbar
        
        datepicker.datePickerMode = mode
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        
        
        if DateTxt.isFirstResponder {
            formatter.dateFormat = "yyyy년 MM월 dd일"
            DateTxt.text = formatter.string(from: datepicker.date)
            DateTxt.resignFirstResponder()
            DateTxt.textColor = .brand1
            reservationIsSelected = true
        } else if TimeTxt.isFirstResponder {
            
            formatter.dateFormat = "HH:mm"
            TimeTxt.text = formatter.string(from: datepicker.date)
            TimeTxt.textColor = .brand1
            view.endEditing(true)
            timeIsSelected = true
        }
    }
    
    @objc
    private func backButtonDidTap() {
        print("Asdf")
        self.navigationController?.popViewController(animated: true)
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [mainImageView, classLabel, shopLabel, spotImageView,timeImageView,callImageView,
         spotLabel, timeLabel, callLabel, dividerView, personLabel, personButton1,
         personButton2, personButton3, DateLabel, DateTxt, TimeLabel, TimeTxt, reserveButton].forEach {
            self.contentView.addSubview($0)
        }
        mainImageView.addSubviews(backButton)
        
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(330)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).inset(10)
            $0.top.equalTo(view.snp.top).inset(62)
            $0.size.equalTo(24)
        }
        
        classLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(350)
            $0.leading.equalToSuperview().inset(16)
        }
        
        shopLabel.snp.makeConstraints {
            $0.top.equalTo(classLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
        }
        
        spotImageView.snp.makeConstraints {
            $0.top.equalTo(shopLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        spotLabel.snp.makeConstraints{
            $0.centerY.equalTo(spotImageView.snp.centerY)
            $0.leading.equalTo(spotImageView.snp.trailing).offset(15)
        }
        
        timeImageView.snp.makeConstraints {
            $0.top.equalTo(spotImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints{
            $0.centerY.equalTo(timeImageView.snp.centerY)
            $0.leading.equalTo(timeImageView.snp.trailing).offset(15)
        }
        
        callImageView.snp.makeConstraints {
            $0.top.equalTo(timeImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        callLabel.snp.makeConstraints{
            $0.centerY.equalTo(callImageView.snp.centerY)
            $0.leading.equalTo(callImageView.snp.trailing).offset(15)
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(callLabel.snp.bottom).offset(28)
        }
        
        personLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(16)
        }
        
        personButton1.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        personButton2.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(12)
            $0.leading.equalTo(personButton1.snp.trailing).offset(10)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        personButton3.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(12)
            $0.leading.equalTo(personButton2.snp.trailing).offset(10)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        
        DateLabel.snp.makeConstraints {
            $0.top.equalTo(personButton1.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }
        
        DateTxt.snp.makeConstraints {
            $0.top.equalTo(DateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(343)
            $0.height.equalTo(44)
        }
        
        TimeLabel.snp.makeConstraints {
            $0.top.equalTo(DateTxt.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }
        
        TimeTxt.snp.makeConstraints {
            $0.top.equalTo(TimeLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(DateTxt)
        }
        
        reserveButton.snp.makeConstraints {
            $0.top.equalTo(TimeTxt.snp.bottom).offset(92)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(343)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(50)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == DateTxt {
            
            datepicker.preferredDatePickerStyle = .inline
            createDatePicker(mode: .date, inputField: DateTxt)
        } else if textField == TimeTxt {
            
            datepicker.preferredDatePickerStyle = .wheels
            createDatePicker(mode: .time, inputField: TimeTxt)
        }
    }
    
    
    @objc
    private func filterButtonDidTap(_ sender: UIButton) {
        for button in filterButton {
            let isSelected = (button == sender)
            button.isSelected = isSelected
            
            if(isSelected) {
                button.backgroundColor = .brand1
                memberIsSelected = true
            } else {
                button.backgroundColor = .grayScale200
            }
        }
    }
    
    @objc
    private func setFilterButton() {
        [personButton1, personButton2, personButton3].forEach { button in
            filterButton.append(button)
        }
    }
    
    @objc
    private func reservationButtonDidTap() {
        let viewController = ReservationCompleteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func activeReservation() {
        if(memberIsSelected && reservationIsSelected && timeIsSelected) {
            reserveButton.isEnabled = true
            reserveButton.backgroundColor = .brand1
        }
    }
}
