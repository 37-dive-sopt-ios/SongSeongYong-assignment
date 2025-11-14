import UIKit
import SnapKit
import Then

class baeminLoginViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let navigationTitleLabel = UILabel()
    private let navigationButton = UIButton()
    private lazy var idTextField = makeTextField(placeholder: "이메일 또는 아이디를 입력해주세요")
    private lazy var passwordTextField = makeTextField(placeholder: "비밀번호")
    private lazy var loginButton = UIButton()
    private let findAccountButton = UIButton()
    
    // MARK: - SetUp Methods
    
    override func setStyle() {
        
        navigationTitleLabel.do {
            $0.text = "이메일 또는 아이디로 계속"
            $0.textColor = .baeminBlack
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(.title_sb_18)
        }
        
        navigationButton.do {
            $0.setImage(UIImage(named: "btnBefore"), for: .normal)
        }
        
        idTextField.do {
            $0.clearButtonMode = .always
        }
        
        passwordTextField.do {
            $0.isSecureTextEntry = true
            
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            clearButton.tintColor = .systemGray3
            clearButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            clearButton.addTarget(self, action: #selector(clearPasswordField), for: .touchUpInside)
            
            let toggleButton = UIButton(type: .custom)
            toggleButton.setImage(UIImage(named: "eye-slash"), for: .normal)
            toggleButton.setImage(UIImage(named: "eye"), for: .selected)
            toggleButton.tintColor = .gray
            toggleButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            
            let stackView = UIStackView(arrangedSubviews: [clearButton, toggleButton])
            stackView.axis = .horizontal
            stackView.spacing = 4
            stackView.frame = CGRect(x: 0, y: 0, width: 60, height: 24)
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            rightView.addSubview(stackView)
            stackView.center = rightView.center
            
            $0.rightView = rightView
            $0.rightViewMode = .always
        }
        
        loginButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(.head_b_18)
            $0.layer.backgroundColor = UIColor(named: "baemin_gray_200")?.cgColor
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
            $0.isEnabled = false
        }
        
        findAccountButton.do {
            $0.setImage(UIImage(named: "findAccount"), for: .normal)
            $0.setTitle("계정 찾기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(.body_r_14)
            $0.setTitleColor(.baeminBlack, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    override func setUI() {
        view.addSubviews(navigationTitleLabel, navigationButton, idTextField, passwordTextField, loginButton, findAccountButton)
    }
    
    override func setLayout() {
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }
        
        navigationButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(70)
            
        }
        
        idTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(36)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalTo(46)
            $0.width.equalTo(343)
        }
        
        findAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    // MARK: - Custom Methods
    
    private func setAddTarget() {
        [idTextField, passwordTextField].forEach { textField in
            textField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        }
        
        idTextField.addTarget(self, action: #selector(idTextFieldFocused), for: .editingDidBegin)
        idTextField.addTarget(self, action: #selector(idTextFieldUnfocused), for: .editingDidEnd)
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldFocused), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldUnfocused), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        idTextField.text = ""
        passwordTextField.text = ""
        
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor(named: "baemin_gray_200")?.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "baemin_gray_200")?.cgColor
        
        loginButton.isEnabled = false
        loginButton.layer.backgroundColor = UIColor(named: "baemin_gray_200")?.cgColor
    }
    
    private func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.pretendard(.body_r_14)
        textField.textColor = UIColor(named: "baemin_gray_700")
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "baemin_gray_200")?.cgColor
        textField.addLeftPadding()
        return textField
    }
    
    @objc
    func idTextFieldFocused() {
        idTextField.layer.borderWidth = 2
        idTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc
    func idTextFieldUnfocused() {
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor(named: "baemin_gray_200")?.cgColor
    }
    
    @objc
    func passwordTextFieldFocused() {
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc
    func passwordTextFieldUnfocused() {
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "baemin_gray_200")?.cgColor
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
            loginButton.layer.backgroundColor = UIColor(named: "baemin_gray_200")?.cgColor
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
}



#Preview {
    baeminLoginViewController()
}
