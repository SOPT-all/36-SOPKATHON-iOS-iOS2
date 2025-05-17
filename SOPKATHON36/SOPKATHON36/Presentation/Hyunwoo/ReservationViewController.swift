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
    
    let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let classLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_24, text: "원데이 클래스")
        $0.textColor = .grayScale800
    }
    
    let shopLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_m_16, text: "매장 이름")
        $0.textColor = .grayScale600
    }
    
    let spotImageView = UIImageView().then {
        $0.image = UIImage(named: "spot")
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
        $0.image = UIImage(named: "time")
        $0.contentMode = .scaleAspectFit
    }
    
    let callImageView = UIImageView().then {
        $0.image = UIImage(named: "call")
        $0.contentMode = .scaleAspectFit
    }
    
    let personLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "인원 선택")
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
        $0.attributedText = .pretendard(.title_sb_16, text: "날짜 선택")
        $0.textColor = .grayScale999
    }
    
    let DateTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
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
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .grayScale200
        $0.borderStyle = .roundedRect
        $0.placeholder = "시간 선택"
    }
    
    let reserveButton = UIButton().then{
        $0.setTitle("예약하기", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .brand1
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
        
        navigationController?.navigationBar.isHidden = true
        
        personButton1.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        personButton2.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        personButton3.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
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
            
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            DateTxt.text = formatter.string(from: datepicker.date)
            DateTxt.resignFirstResponder()
        } else if TimeTxt.isFirstResponder {
            
            formatter.dateFormat = "HH:mm"
            TimeTxt.text = formatter.string(from: datepicker.date)
            TimeTxt.textColor = .brand1
            view.endEditing(true)
        }
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
        
        [classLabel, shopLabel, spotImageView,timeImageView,callImageView,
         spotLabel, timeLabel, callLabel,personLabel, personButton1,
         personButton2, personButton3, DateLabel, DateTxt, TimeLabel, TimeTxt, reserveButton].forEach {
            self.contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        classLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(350)
            $0.leading.equalToSuperview().inset(16)
        }
        
        shopLabel.snp.makeConstraints {
            $0.top.equalTo(classLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(16)
        }
        
        spotImageView.snp.makeConstraints {
            $0.top.equalTo(shopLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        spotLabel.snp.makeConstraints{
            $0.centerY.equalTo(spotImageView.snp.centerY)
            $0.leading.equalTo(spotImageView.snp.trailing).offset(15)
        }
        
        timeImageView.snp.makeConstraints {
            $0.top.equalTo(spotImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints{
            $0.centerY.equalTo(timeImageView.snp.centerY)
            $0.leading.equalTo(timeImageView.snp.trailing).offset(15)
        }
        
        callImageView.snp.makeConstraints {
            $0.top.equalTo(timeImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        callLabel.snp.makeConstraints{
            $0.centerY.equalTo(callImageView.snp.centerY)
            $0.leading.equalTo(callImageView.snp.trailing).offset(15)
        }
        
        personLabel.snp.makeConstraints {
            $0.top.equalTo(callImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(16)
        }
        
        personButton1.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        personButton2.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(10)
            $0.leading.equalTo(personButton1.snp.trailing).offset(10)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        personButton3.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(10)
            $0.leading.equalTo(personButton2.snp.trailing).offset(10)
            $0.width.equalTo(31)
            $0.height.equalTo(28)
        }
        
        
        DateLabel.snp.makeConstraints {
            $0.top.equalTo(personButton1.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(16)
        }
        
        DateTxt.snp.makeConstraints {
            $0.top.equalTo(DateLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(343)
            $0.height.equalTo(44)
        }
        
        TimeLabel.snp.makeConstraints {
            $0.top.equalTo(DateTxt.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(16)
        }
        
        TimeTxt.snp.makeConstraints {
            $0.top.equalTo(TimeLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(DateTxt)
        }
        
        reserveButton.snp.makeConstraints {
            $0.top.equalTo(TimeTxt.snp.bottom).offset(40)
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
}
