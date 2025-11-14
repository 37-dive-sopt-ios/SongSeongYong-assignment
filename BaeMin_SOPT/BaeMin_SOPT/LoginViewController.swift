import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(resource: .arrowLeft), for: .normal)
        $0.tintColor = . baeminBlack
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이메일 또는 아이디로 계속"
        $0.textColor = .baeminBlack
        $0.font = UIFont.title_sb_18
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "이메일 또는 아이디를 입력해 주세요"
        $0.textColor = .baeminGray700
        $0.borderStyle = .none
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(resource: .baeminGray200).cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        $0.leftViewMode = .always
        $0.clearButtonMode = .whileEditing
        $0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        $0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.textColor = .baeminGray700
        $0.borderStyle = .none
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(resource: .baeminGray200).cgColor
        $0.addPadding(leftAmount: 10)
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        $0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)

        
        // 보기/숨기기 버튼
        let secureButton = UIButton(type: .custom)
        secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secureButton.setImage(UIImage(systemName: "eye"), for: .selected)
        secureButton.tintColor = .baeminGray300
        secureButton.addTarget(self, action: #selector(toggleSecureEntry), for: .touchUpInside)
        
        // 지우기 버튼
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor =  .baeminGray300
        clearButton.addTarget(self, action: #selector(clearPasswordText), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [clearButton, secureButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10)
        
        $0.rightView = stackView
        $0.rightViewMode = .never
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = .head_b_18
        $0.isEnabled = false
        $0.backgroundColor = .baeminGray200
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private let findAccountButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.title = "계정 찾기"
        config.image = UIImage(resource: .chevronRight)
        config.imagePlacement = .trailing
        config.imagePadding = 4
        
        $0.configuration = config
        $0.tintColor = .baeminBlack
        $0.setTitleColor(.baeminBlack, for: .normal)
    }
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setUI()
        setLayout()
        validateInput()
    }

    // MARK: - Setup Methods
    
    private func setStyle() {
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setUI() {
        view.addSubviews(backButton, titleLabel,
                         idTextField, passwordTextField,
                         loginButton, findAccountButton)
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
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        findAccountButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func validateInput() {
        let isIdValid = !(idTextField.text?.isEmpty ?? true)
        let isPasswordValid = !(passwordTextField.text?.isEmpty ?? true)
        let isFormValid = isIdValid && isPasswordValid
        loginButton.isEnabled = isFormValid
        loginButton.backgroundColor = isFormValid ? .baeminMint500 : .baeminGray200
    }
    
    private func clearTextField() {
        idTextField.text = ""
        passwordTextField.text = ""
        idTextField.layer.borderColor = UIColor(resource: .baeminGray200).cgColor
        passwordTextField.layer.borderColor = UIColor(resource: .baeminGray200).cgColor
        
        view.endEditing(true)
        textFieldDidChange(passwordTextField)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            textField.rightViewMode = textField.text?.isEmpty == false ? .always : .never
        }
        validateInput()
    }
    
    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminBlack.cgColor
    }

    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
    }
    
    @objc private func toggleSecureEntry(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc private func loginButtonTapped() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.delegate = self
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    @objc private func clearPasswordText() {
        passwordTextField.text = ""
        textFieldDidChange(passwordTextField)
        validateInput()
    }
}

extension LoginViewController: WelcomeViewControllerDelegate {
    func getIDForWelcomeView() -> String? {
        return idTextField.text
    }
    
    func willPopToLogin() {
        clearTextField()

    }
}

#Preview {
    UINavigationController(rootViewController: LoginViewController())
}

