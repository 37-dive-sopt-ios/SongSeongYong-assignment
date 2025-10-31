//
//  LoginViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 10/8/25.
//

import UIKit
import SnapKit


final class LoginViewController_Delegate: UIViewController {

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.layer.cornerRadius = 3
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addLeftPadding()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.layer.cornerRadius = 3
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.configuration = .glass()
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Delegate()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        welcomeViewController.delegate = self
        self.present(welcomeViewController, animated: true)
    }
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Delegate()
        welcomeViewController.id = idTextField.text
        welcomeViewController.delegate = self
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
        }
        
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(163)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(422)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
            
        }
        
        idTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(72)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
            
        }
        
        passwordTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
            
        }
        
        
        
        
        
        
        
        /*
        NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     titleLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 163)])

        NSLayoutConstraint.activate([loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
                                     loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     loginButton.heightAnchor.constraint(equalToConstant: 58)])
        
        NSLayoutConstraint.activate([idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     idTextField.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 72),
                                     idTextField.heightAnchor.constraint(equalToConstant: 52),
                                     idTextField.widthAnchor.constraint(equalToConstant: 335)])
        
        NSLayoutConstraint.activate([passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 6),
                                     passwordTextField.heightAnchor.constraint(equalToConstant: 52),
                                     passwordTextField.widthAnchor.constraint(equalToConstant: 335)])
        */
                                    
    }

    
    @objc
    private func loginButtonDidTap() {
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    
    
    func retryLogin(didTapReloginWith message: String) {
        titleLabel.text = message
        idTextField.text = ""
        passwordTextField.text = ""
        loginButton.setTitle("다시 로그인하기", for: .normal)
    }

}


extension LoginViewController_Delegate: WelcomeReloginDelegate {
    public func retryLogin(_ viewController: UIViewController, didTapReloginWith message: String) {
        titleLabel.text = message
        idTextField.text = ""
        passwordTextField.text = ""
        loginButton.setTitle("다시 로그인하기", for: .normal)
    }
}

#Preview { LoginViewController_Delegate() }
