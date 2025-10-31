//
//  baeminWelcomeViewController.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 10/31/25.
//

import UIKit
import SnapKit
import Foundation
import SwiftUI


class baeminWelcomeViewController: UIViewController {
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대체 뼈짐 누가 시켰어??"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        return label
    }()
    
    
    private let welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImage")
        return imageView
    }()
    
    private let welcomeText: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 24)
        return label
    }()
    
    private let welcomeText2: UILabel = {
        let label = UILabel()
        label.text = "00님 반가워요!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        return label
    }()
    
    private lazy var backToLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle("뒤로가기", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        button.layer.backgroundColor = UIColor(named: "baemin_mint_500")?.cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)

        return button
    }()
    
    
    @objc
    private func backToLoginButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    var email: String?

    private func bindID() {
        guard let welcomeText2 = email else { return }
            self.welcomeText2.text = "\(welcomeText2)님 \n반가워요!"
    }
    
    
    
    private func setLayout() {
        [navigationTitleLabel, welcomeImage, welcomeText, welcomeText2, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }

        
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(18)
            $0.width.equalToSuperview()
            $0.height.equalTo(220)
            $0.centerX.equalToSuperview()
        }
        
        welcomeText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeImage.snp.bottom).offset(24)

        }
        
        welcomeText2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeText.snp.bottom).offset(16)

        }
        
        backToLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeText2.snp.bottom).offset(326)
            $0.height.equalTo(52)
            $0.width.equalTo(343)
        }

        }
    
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        
        bindID()
    }
    
    
}

#Preview {
    baeminWelcomeViewController()
}
