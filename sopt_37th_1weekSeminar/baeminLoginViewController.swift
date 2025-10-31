//
//  baeminLoginViewController.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 10/31/25.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class baeminLoginViewController: UIViewController {
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 아이디로 계속"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        return label
    }()
    
    
    private let navigationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnBefore"), for: .normal)
        return button
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 또는 아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
        textField.clearButtonMode = .always
        textField.addLeftPadding()
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
        textField.isSecureTextEntry = true
        textField.addLeftPadding()
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .systemGray3
        clearButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        clearButton.addTarget(self, action: #selector(clearPasswordField), for: .touchUpInside)
        
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye-slash"), for: .normal)
        button.setImage(UIImage(named: "eye"), for: .selected)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [clearButton, button])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.frame = CGRect(x: 0, y: 0, width: 60, height: 24)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        rightView.addSubview(stackView)
        stackView.center = rightView.center
        
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.backgroundColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        //  button.addTarget(self, action: #selector(pushToWelcomeVC), for: .touchUpInside)

        button.isEnabled = false
        
        
        return button
    }()
    
    private let findAccountButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "findAccount"), for: .normal)
        button.setTitle("계정 찾기", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.setTitleColor(.black, for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        
        
        
        
        return button
    }()
    
    
    
    private func setLayout() {
        [navigationTitleLabel, navigationButton, idTextField, passwordTextField,loginButton,findAccountButton].forEach {
            self.view.addSubview($0)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }
        
        navigationButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(70)
            
        }
        
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(36)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        findAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            
        }
        
    }
    
    
    @objc
    func idTextFieldFocused() {
        idTextField.layer.borderWidth = 2
        idTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc
    func idTextFieldUnfocused() {
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
    }
    
    @objc
    func passwordTextFieldFocused() {
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc
    func passwordTextFieldUnfocused() {
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
    }
    
    @objc private func clearPasswordField() {
        passwordTextField.text = ""
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    
    
    @objc private func textFieldsChanged() {
        let email = idTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let emailFilled = !email.isEmpty
        let passwordFilled = !password.isEmpty
        
        let canLogin = emailFilled && passwordFilled
        
        loginButton.isEnabled = canLogin
        
        if canLogin {
            loginButton.layer.backgroundColor = UIColor(named: "baemin_mint_500")?.cgColor
        } else {
            loginButton.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
        }
    }
    
    
    @objc private func loginButtonTapped() {

        let email = idTextField.text!
        let password = passwordTextField.text!
        
        
        if !isValidEmail(email) {
            showAlert(message: "올바른 이메일 형식이 아닙니다")
            return
        } else {
            pushToWelcomeVC()
        }
    }
    

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    @objc
    private func pushToWelcomeVC() {
        let baeminWelcomeViewController = baeminWelcomeViewController()
        baeminWelcomeViewController.email = idTextField.text
        self.navigationController?.pushViewController(baeminWelcomeViewController, animated: true)
    }
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            setLayout()
            
            idTextField.addTarget(self, action: #selector(idTextFieldFocused), for: .editingDidBegin)
            
            idTextField.addTarget(self, action: #selector(idTextFieldUnfocused), for: .editingDidEnd)
            
            passwordTextField.addTarget(self, action: #selector(passwordTextFieldFocused), for: .editingDidBegin)
            
            passwordTextField.addTarget(self, action: #selector(passwordTextFieldUnfocused), for: .editingDidEnd)
            
            idTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
            passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
            
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            idTextField.text = ""
            passwordTextField.text = ""
            
            idTextField.layer.borderWidth = 1
            idTextField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
            
            loginButton.isEnabled = false
            loginButton.layer.backgroundColor = UIColor(red: 0.82, green: 0.827, blue: 0.851, alpha: 1).cgColor
        }
    
    
    
    
    }



#Preview {
    baeminLoginViewController()
}
