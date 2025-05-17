//
//  DateTestViewController.swift
//  SOPKATHON36
//
//  Created by hyunwoo on 5/17/25.
//

import UIKit

import SnapKit
import Then

class DateTestViewController: UIViewController, UITextFieldDelegate {
    let DateTxt = UITextField().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .grayScale300
        $0.borderStyle = .roundedRect
    }
    
    let datepicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        createDatePicker()
        
        datepicker.preferredDatePickerStyle = .inline
        datepicker.locale = Locale(identifier: "ko-KR")
        //datepicker.datePickerMode = .time
        DateTxt.delegate = self  // delegate 지정
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        DateTxt.inputAccessoryView = toolbar
        DateTxt.inputView = datepicker
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        //ageTxt.text = formatter.string(from: datepicker.date)
        //formatter.dateFormat = "HH:mm" // 24시간 형식 시간만
            
        DateTxt.text = formatter.string(from: datepicker.date)

        view.endEditing(true)
    }
    
    private func setLayout() {
        view.addSubview(DateTxt)
        
        DateTxt.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
    }
    
    // UITextFieldDelegate - 선택 시 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트필드가 선택되었음")
        // 필요하면 여기서 추가 작업 가능
    }
}
