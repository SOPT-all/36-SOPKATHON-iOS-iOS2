//
//  LoginViewController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    
    private let loginTextField = UITextField()
    
    private let loginButton = UIButton(type: .system)
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setUI()
        setLayout()
        setAction()
        setDelegate()
        hideKeyboardWhenDidTap(cancelsTouches: true)
    }
    
    // MARK: - UI Setting
    
    private func setStyle() {
        view.do {
            $0.backgroundColor = .brand1
        }
        
        logoImageView.do {
            $0.image = .splash
            $0.contentMode = .scaleAspectFit
        }
        
        loginTextField.do {
            $0.placeholder = "전화번호를 입력해주세요"
            $0.backgroundColor = .brand2
            $0.addPadding(left: 20)
            $0.configureDefaultTextField()
            $0.setCornerRadius(8)
            $0.setBorder(borderColor: .grayScale000)
            $0.setPlaceholderColor(.brand3)
            $0.keyboardType = .numberPad
            $0.font = .pretendard(.title_m_14)
            $0.textColor = .grayScale000
        }
        
        loginButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.attributedText = .pretendard(.title_sb_16, text: "로그인")
            $0.setTitleColor(.brand1, for: .normal)
            $0.setTitleColor(.brand3, for: .disabled)
            $0.backgroundColor = .brand2
            $0.isEnabled = false
            $0.setCornerRadius(8)
        }
    }
    
    private func setUI() {
        view.addSubviews(logoImageView, loginTextField, loginButton)
    }
    
    private func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(190)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        loginTextField.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-13)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Action
    
    private func setAction() {
        loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
    
    private func setDelegate() {
        loginTextField.delegate = self
    }
}

// MARK: - Functions

extension LoginViewController {
    @objc
    private func loginButtonDidTap() {
        guard let phoneNumber = loginTextField.text, phoneNumber.isValidPhoneNumber else {
            showAlert(title: "유효한 전화번호를 입력해 주세요", message: "형식: 010-xxxx-xxxx")
            return
        }
        
        let viewControler = OnboardingViewController()
        viewControler.number = phoneNumber
        navigationController?.pushViewController(viewControler, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let currentText = textField.text as NSString? else { return true }

        // 새로운 문자열 만들기
        let newText = currentText.replacingCharacters(in: range, with: string)
        // 숫자만 추출
        let digits = newText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        // 최대 11자리까지만 허용
        if digits.count > 11 {
            return false
        }

        // 하이픈(-) 포함된 포맷팅된 문자열 만들기
        var result = ""
        let characters = Array(digits)

        for (index, char) in characters.enumerated() {
            if index == 3 || index == 7 {
                result.append("-")
            }
            result.append(char)
        }

        textField.text = result

        // 👉 여기에 버튼 활성화 로직 포함
        if result.isEmpty {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .brand2
        } else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .grayScale000
        }

        return false
    }
}
