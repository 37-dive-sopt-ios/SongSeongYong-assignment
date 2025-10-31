//
//  WelcomeViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 10/8/25.
//

import UIKit

protocol WelcomeReloginDelegate: AnyObject {
    func retryLogin(didTapReloginWith message: String)
}

final class WelcomeViewController_Delegate: UIViewController {
    
    var id: String?
    
    weak var delegate: WelcomeReloginDelegate?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 112, y: 87, width: 150, height: 150))
        imageView.image = UIImage(named: "logo2")
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 140, y: 295, width: 95, height: 60))
        label.text = "???님 \n반가워요!"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var goHomeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 426, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.configuration = .glass()
        return button
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 498, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.configuration = .glass()
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
        bindID()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        [logoImageView, welcomeLabel, goHomeButton, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func bindID() {
        guard let id = id else { return }
        self.welcomeLabel.text = "\(id)님 \n반가워요!"
    }
    
    @objc
    private func backToLoginButtonDidTap() {
        
        delegate?.retryLogin(didTapReloginWith: "다시 로그인 버튼을 눌렀어요!")
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
