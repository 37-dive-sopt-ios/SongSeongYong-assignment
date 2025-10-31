//
//  Untitled.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 10/18/25.
//

import UIKit
import SnapKit

final class ColorViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private var contentView = UIView()
    

    
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    private let orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    
    
    private func setLayout(){
        
        let viewWidth = UIScreen.main.bounds.width/2

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [greenView, blueView, orangeView, redView,yellowView,purpleView].forEach({
            contentView.addSubview($0)
        })
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            
            $0.height.greaterThanOrEqualToSuperview().priority(.low)

        }
        
        greenView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            $0.top.equalTo(contentView)
            
        }
        
        
        blueView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            $0.top.equalTo(contentView)
            
        }
        
        orangeView.snp.makeConstraints {
            $0.top.equalTo(greenView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            
        }
        
        redView.snp.makeConstraints {
            $0.top.equalTo(blueView.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            
        }
        
        yellowView.snp.makeConstraints {
            $0.top.equalTo(orangeView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            $0.bottom.equalTo(contentView)

            
        }
        
        purpleView.snp.makeConstraints {
            $0.top.equalTo(redView.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(400)
            $0.bottom.equalTo(contentView)

            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
}

#Preview{
    ColorViewController()
}




