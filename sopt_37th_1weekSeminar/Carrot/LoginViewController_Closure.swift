//
//  LoginViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 10/8/25.
//

import UIKit

final class LoginViewController_Closure: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 69, y: 161, width: 236, height: 44))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.layer.cornerRadius = 3
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addLeftPadding()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.layer.cornerRadius = 3
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 21, y: 422, width: 332, height: 58))
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
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        self.present(welcomeViewController, animated: true)
    }
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Closure()
        welcomeViewController.id = idTextField.text
        
        // completionHandler 정의하기!
        welcomeViewController.completionHandler = { [weak self] message in
            self?.handleCompletion(message: message)
        }
        
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    private func handleCompletion(message: String) {
            titleLabel.text = message
            idTextField.text = ""
            passwordTextField.text = ""
            loginButton.setTitle("다시 로그인하기", for: .normal)
        }
    
    @objc
    private func loginButtonDidTap() {
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    

}

