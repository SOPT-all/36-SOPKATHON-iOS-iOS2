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
    
    let DateLabel = UILabel().then {
        $0.text = "날짜 선택"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .grayScale999
    }
    
    let DateTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .grayScale300
        $0.borderStyle = .roundedRect
        $0.placeholder = "날짜 선택"
    }
    
    let TimeLabel = UILabel().then {
        $0.text = "시간 선택"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .grayScale999
    }
    
    let TimeTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .grayScale300
        $0.borderStyle = .roundedRect
        $0.placeholder = "시간 선택"
    }
    
    let datepicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()

        DateTxt.delegate = self
        TimeTxt.delegate = self
        
        datepicker.locale = Locale(identifier: "ko-KR")
        datepicker.preferredDatePickerStyle = .inline
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func createDatePicker(mode: UIDatePicker.Mode, inputField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(donePressed))
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
            view.endEditing(true)
        }
    }
    
    private func setLayout() {
        [DateLabel,DateTxt,TimeLabel,TimeTxt].forEach {
            view.addSubview($0)
        }
        DateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().inset(40)
        }
        
        DateTxt.snp.makeConstraints {
            $0.top.equalTo(DateLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        TimeLabel.snp.makeConstraints {
            $0.top.equalTo(DateTxt.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(40)
        }
        
        TimeTxt.snp.makeConstraints {
            $0.top.equalTo(TimeLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(40)
            $0.width.height.equalTo(DateTxt)
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
}
