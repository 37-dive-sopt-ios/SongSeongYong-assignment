import UIKit

import SnapKit
import Then

protocol WelcomeViewControllerDelegate: AnyObject {
    func getIDForWelcomeView() -> String?
    func willPopToLogin()
}

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WelcomeViewControllerDelegate?
    
    // MARK: - UI Components
    
    private let backButton: UIButton
    private let titleLabel: UILabel
    private let imageView: UIImageView
    private let welcomeLabel: UILabel
    private let idLabel: UILabel
    private let loginButton: UIButton
    
    // MARK: - Initializers
    
    init() {
        backButton = UIButton(type: .system)
        titleLabel = UILabel()
        imageView = UIImageView()
        welcomeLabel = UILabel()
        idLabel = UILabel()
        loginButton = UIButton(type: .system)
        
        super.init(nibName: nil, bundle: nil)
        
        do {
            backButton.setImage(UIImage(resource: .arrowLeft), for: .normal)
            backButton.tintColor = .baeminBlack
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
        
        do {
            titleLabel.text = "환영합니다"
            titleLabel.textColor = .baeminBlack
            titleLabel.font = UIFont.title_sb_18
        }
        
        do {
            imageView.image = UIImage(resource: .baemin)
            imageView.contentMode = .scaleAspectFill
        }
        
        do {
            welcomeLabel.text = "환영합니다"
            welcomeLabel.textColor = .baeminBlack
            welcomeLabel.font = UIFont.head_b_24
        }
        
        do {
            idLabel.text = "oo님 반가워요!"
            idLabel.textColor = .baeminBlack
            idLabel.font = UIFont.title_sb_18
        }
        
        do {
            loginButton.setTitle("메인으로 가기", for: .normal)
            loginButton.backgroundColor = .baeminMint500
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.layer.cornerRadius = 4
            loginButton.titleLabel?.font = .head_b_18
            loginButton.addTarget(self, action: #selector(goToMainButtonTapped), for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setUI()
        setLayout()
        setDelegate()
    }
    
    // MARK: - Setup Methods
    
    private func setStyle() {
        view.backgroundColor = .white
    }
    
    private func setUI() {
        view.addSubviews(backButton, titleLabel,
                         imageView, welcomeLabel, idLabel,
                         loginButton)
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(52)
            $0.leading.equalToSuperview().inset(8)
            $0.size.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.height.equalTo(211)
            $0.horizontalEdges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(24)
        }
        
        idLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
    
    private func setDelegate() {
        guard let id = delegate?.getIDForWelcomeView(), !id.isEmpty else {
            return
        }
        idLabel.text = "\(id)님 반가워요!"
    }
    
    @objc private func backButtonTapped() {
        delegate?.willPopToLogin()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func goToMainButtonTapped() {
        let mainVC = TabBarController()
        self.navigationController?.setViewControllers([mainVC], animated: true)
    }
}

#Preview {
    WelcomeViewController()
}

