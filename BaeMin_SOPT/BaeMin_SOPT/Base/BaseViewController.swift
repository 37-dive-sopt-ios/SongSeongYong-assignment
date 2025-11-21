//
//  BaseViewController.swift
//  BaeMin_SOPT
//
//  Created by 송성용 on 11/20/25.
//

import Foundation
import UIKit

/// - POP(Protocol Oriented Programming) 적용
open class BaseViewController: UIViewController, Alertable, LoadingIndicatorable {
    
    // MARK: - UI Components
    
    /// Loading Indicator 공통 컴포넌트 (모든 하위 ViewController에서 사용 가능)
    public let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - LifeCycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseUI()
        setStyle()
        setUI()
        setLayout()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 하위 클래스에서 뷰를 추가한 후에도 항상 loadingIndicator가 최상위에 위치하게 하도록 함
        view.bringSubviewToFront(loadingIndicator)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - UI Setup
    
    /// Base UI 설정 (loadingIndicator, 키보드 제스처 등)
    func setBaseUI() {
        view.backgroundColor = .white
        
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // 탭 제스처로 키보드 닫기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    /// UI 컴포넌트 속성 설정 (do 메서드 관련)
    func setStyle() {}
    
    /// UI 위계 설정 (addSubView 등)
    func setUI() {}
    
    /// 오토레이아웃 설정 (SnapKit 코드 관련)
    func setLayout() {}
    
    // MARK: - Methods
    
    /// 키보드 닫기
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
