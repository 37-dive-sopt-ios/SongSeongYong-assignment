import UIKit
import SnapKit
import Foundation
import Then

class baeminWelcomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var email: String?
 
    
    // MARK: - UI Componets
    
    private let navigationTitleLabel = UILabel()
    private let welcomeImage = UIImageView()
    private let welcomeText = UILabel()
    private let welcomeText2 = UILabel()
    private lazy var backToLoginButton = UIButton()
    
    
    // MARK: - SetUp Methods
    
    override func setStyle() {
        
        navigationTitleLabel.do {
            $0.text = "대체 뼈짐 누가 시켰어??"
            $0.textColor = .baeminBlack
            $0.font = UIFont.pretendard(.title_sb_18)
        }
        
        welcomeImage.do {
            $0.image = UIImage(named: "welcomeImage")
        }
        
        welcomeText.do {
            $0.text = "환영합니다"
            $0.textColor = .black
            $0.font = UIFont.pretendard(.head_b_24)
        }
        
        welcomeText2.do {
            $0.text = "00님 반가워요!"
            $0.textColor = .black
            $0.font = UIFont.pretendard(.title_sb_18)
        }
        
        backToLoginButton.do {
            $0.setTitle("뒤로가기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(.title_sb_18)
            $0.layer.backgroundColor = UIColor(named: "baemin_mint_500")?.cgColor
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        }
    }
    
    override func setUI() {
        
        [navigationTitleLabel, welcomeImage, welcomeText, welcomeText2, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    override func setLayout() {
        
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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindID()
    }

    // MARK: - Custom Methods
    
    @objc
    private func backToLoginButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func bindID() {
        guard let welcomeText2 = email else { return }
            self.welcomeText2.text = "\(welcomeText2)님 \n반가워요!"
    }
    
}

#Preview {
    baeminWelcomeViewController()
}
