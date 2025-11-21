//
//  WelcomeViewController_Network.swift
//  BaeMin_SOPT
//
//  Created by 송성용 on 11/20/25.
//

import UIKit
import SnapKit

final class WelcomeViewController_Network: BaseViewController {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다!"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 정보를 조회해보세요"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var getUserButton: UIButton = {
        let button = createButton(title: "사용자 정보 조회\n(GET /api/v1/users/{id})", color: .systemBlue)
        button.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var updateUserButton: UIButton = {
        let button = createButton(title: "사용자 정보 수정\n(PATCH /api/v1/users/{id})", color: .systemOrange)
        button.addTarget(self, action: #selector(updateUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteUserButton: UIButton = {
        let button = createButton(title: "사용자 삭제\n(DELETE /api/v1/users/{id})", color: .systemRed)
        button.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    
    private let provider: NetworkProviding
    private var userId: Int = 1 // 기본값, 로그인/회원가입에서 전달받을 수 있음
    
    // MARK: - Init
    
    public init(userId: Int = 1, provider: NetworkProviding = NetworkProvider()) {
        self.userId = userId
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
    }
    
    // MARK: - UI Setup
    
    override func setUI() {
        view.addSubviews(
            titleLabel,
            userInfoLabel,
            getUserButton,
            updateUserButton,
            deleteUserButton
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        getUserButton.snp.makeConstraints {
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        updateUserButton.snp.makeConstraints {
            $0.top.equalTo(getUserButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        deleteUserButton.snp.makeConstraints {
            $0.top.equalTo(updateUserButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Actions
    
    @objc private func getUserButtonTapped() {
        Task {
            await performGetUser()
        }
    }

    @objc private func updateUserButtonTapped() {
        showUpdateUserDialog()
    }
    
    @objc private func deleteUserButtonTapped() {
        showDeleteConfirmation()
    }
    
    // MARK: - Network Methods
    
    /// 사용자 정보 조회
    @MainActor
    private func performGetUser() async {
        startLoading()
        
        do {
            // UserAPI의 convenience method 사용
            let user = try await UserAPI.performGetUser(
                userId: userId,
                provider: provider
            )
            
            // 사용자 정보 표시
            let info = """
            ID: \(user.id)
            Username: \(user.username)
            Name: \(user.name)
            Email: \(user.email)
            Age: \(user.age)
            """
            
            userInfoLabel.text = info
            showAlert(title: "조회 성공", message: "사용자 정보를 불러왔습니다!")
            
        } catch let error as NetworkError {
            print("🚨 [Get User Error] \(error.detailedDescription)")
            showAlert(title: "조회 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Get User Unknown Error] \(error)")
            showAlert(title: "조회 실패", message: error.localizedDescription)
        }
        
        stopLoading()
    }
    
    /// 사용자 정보 수정
    @MainActor
    private func performUpdateUser(name: String?, email: String?, age: Int?) async {
        startLoading()
        
        do {
            // UserAPI의 convenience method 사용
            let user = try await UserAPI.performUpdateUser(
                userId: userId,
                name: name,
                email: email,
                age: age,
                provider: provider
            )
            
            // 업데이트된 정보 표시
            let info = """
            ID: \(user.id)
            Username: \(user.username)
            Name: \(user.name)
            Email: \(user.email)
            Age: \(user.age)
            """
            
            userInfoLabel.text = info
            showAlert(title: "수정 성공", message: "사용자 정보가 업데이트되었습니다!")
            
        } catch let error as NetworkError {
            print("🚨 [Update User Error] \(error.detailedDescription)")
            showAlert(title: "수정 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Update User Unknown Error] \(error)")
            showAlert(title: "수정 실패", message: error.localizedDescription)
        }
        
        stopLoading()
    }
    
    /// 사용자 삭제
    @MainActor
    private func performDeleteUser() async {
        startLoading()
        
        do {
            // UserAPI의 convenience method 사용
            try await UserAPI.performDeleteUser(
                userId: userId,
                provider: provider
            )
            
            showAlert(title: "삭제 성공", message: "사용자가 삭제되었습니다.") { [weak self] in
                // 삭제 후 로그인 화면으로 돌아가기
                self?.navigationController?.popToRootViewController(animated: true)
            }
            
        } catch let error as NetworkError {
            print("🚨 [Delete User Error] \(error.detailedDescription)")
            showAlert(title: "삭제 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Delete User Unknown Error] \(error)")
            showAlert(title: "삭제 실패", message: error.localizedDescription)
        }
        
        stopLoading()
    }
    
    // MARK: - Helpers
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 8
        return button
    }
    
    private func showUpdateUserDialog() {
        let alert = UIAlertController(
            title: "사용자 정보 수정",
            message: "수정할 정보를 입력하세요 (비워두면 변경되지 않습니다)",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "이름"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "이메일"
            textField.keyboardType = .emailAddress
        }
        
        alert.addTextField { textField in
            textField.placeholder = "나이"
            textField.keyboardType = .numberPad
        }
        
        let updateAction = UIAlertAction(title: "수정", style: .default) { [weak self, weak alert] _ in
            guard let self = self, let alert = alert else { return }
            
            let name = alert.textFields?[0].text
            let email = alert.textFields?[1].text
            let ageText = alert.textFields?[2].text
            let age = ageText.flatMap { Int($0) }
            
            // 최소 하나는 입력되어야 함
            if name?.isEmpty != false && email?.isEmpty != false && age == nil {
                self.showAlert(title: "입력 오류", message: "최소 하나의 필드를 입력해주세요.")
                return
            }
            
            Task {
                await self.performUpdateUser(
                    name: name?.isEmpty == false ? name : nil,
                    email: email?.isEmpty == false ? email : nil,
                    age: age
                )
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showDeleteConfirmation() {
        let alert = UIAlertController(
            title: "사용자 삭제",
            message: "정말로 사용자를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            Task {
                await self?.performDeleteUser()
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}


#Preview {
    WelcomeViewController_Network()
}
