//
//  BaseViewController.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 11/5/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    /// UI 컴포넌트 속성 설정 (do 메서드 관련)
    func setStyle() {}
    
    /// UI 위계 설정 (addSubView 등)
    func setUI() {}
    
    /// 오토레이아웃 설정 (SnapKit 코드 관련)
    func setLayout() {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baeminWhite
        setStyle()
        setUI()
        setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

