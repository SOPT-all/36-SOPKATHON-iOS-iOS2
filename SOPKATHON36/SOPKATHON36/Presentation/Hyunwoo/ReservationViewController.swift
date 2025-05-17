import SnapKit
import Then
//
//  ReservationViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//
import UIKit

class ReservationViewController: UIViewController, UITextFieldDelegate {

    let personLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "인원 선택")
        $0.textColor = .grayScale999
    }
    let personButton1 = UIButton(type: .system).then {
        $0.setTitle("1명", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .grayScale200
    }

    let personButton2 = UIButton(type: .system).then {
        $0.setTitle("2명", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .grayScale200
    }

    let personButton3 = UIButton(type: .system).then {
        $0.setTitle("3명", for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .grayScale200
    }

    let DateLabel = UILabel().then {
        $0.attributedText = .pretendard(.title_sb_16, text: "날짜 선택")
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
        $0.attributedText = .pretendard(.title_sb_16, text: "시간 선택")
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
            view.endEditing(true)
        }
    }

    private func setLayout() {
        [personLabel, personButton1, personButton2, personButton3,
            DateLabel, DateTxt, TimeLabel, TimeTxt].forEach {
            view.addSubview($0)
        }
        
        personLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
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
            $0.top.equalToSuperview().offset(170)
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
