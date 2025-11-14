import UIKit

import SnapKit
import Then

final class HeaderView: UIView {

    // MARK: - UI Components
    
    private let locationButton: UIButton
    private let stackView: UIStackView
    private let benefitButton: UIButton
    private let notiButton: UIButton
    private let basketButton: UIButton
    private let textField: UITextField
    private let imageView: UIImageView
    private let specialPriceButton: UIButton
    private let gradientLayer: CAGradientLayer

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        locationButton = UIButton(type: .system)
        stackView = UIStackView()
        benefitButton = UIButton(type: .custom)
        notiButton = UIButton(type: .custom)
        basketButton = UIButton(type: .custom)
        textField = UITextField()
        imageView = UIImageView()
        specialPriceButton = UIButton(type: .system)
        gradientLayer = CAGradientLayer()
        
        super.init(frame: frame)
        
        do {
            locationButton.configuration = .plain()
            locationButton.configuration?.title = "우리집"
            locationButton.configuration?.attributedTitle?.font = .head_b_16
            locationButton.configuration?.image = .polygon
            locationButton.configuration?.imagePlacement = .trailing
            locationButton.configuration?.imagePadding = 3
            locationButton.configuration?.baseForegroundColor = .baeminBlack
            locationButton.configuration?.contentInsets = .zero
        }
        
        do {
            stackView.axis = .horizontal
            stackView.spacing = 12
            stackView.alignment = .center
        }
        
        do {
            benefitButton.setImage(.icon1, for: .normal)
        }
        
        do {
            notiButton.setImage(.icon2, for: .normal)
        }
        
        do {
            basketButton.setImage(.icon3, for: .normal)
        }
        
        do {
            textField.backgroundColor = .white
            textField.placeholder = "찾아라! 맛있는 음식과 맛집"
            textField.font = .body_r_14
            textField.layer.cornerRadius = 20
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.baeminBlack.cgColor
            
            let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
            textField.leftView = leftPadding
            textField.leftViewMode = .always
            
            let iconImage = UIImage(resource: .searchIcon)
            let iconView = UIImageView(image: iconImage)
            iconView.tintColor = .baeminBlack
            
            let iconContainer = UIView()
            let padding = 17
            let iconSize = 24
            
            iconContainer.frame = CGRect(x: 0, y: 0, width: iconSize + padding, height: iconSize)
            
            iconContainer.addSubview(iconView)
            textField.rightView = iconContainer
            textField.rightViewMode = .always
        }
        
        do {
            imageView.image = .bMartImg
        }
        
        do {
            specialPriceButton.configuration = .plain()
            specialPriceButton.configuration?.title = "전상품 쿠폰팩 + 60%특가"
            specialPriceButton.configuration?.attributedTitle?.font = .head_b_16
            specialPriceButton.configuration?.image = .chevronRight
            specialPriceButton.configuration?.imagePlacement = .trailing
            specialPriceButton.configuration?.imagePadding = 2
            specialPriceButton.configuration?.baseForegroundColor = .baeminBlack
            specialPriceButton.configuration?.contentInsets = .zero
        }
        
        do {
            let topColor = UIColor.baeminMint300.withAlphaComponent(0.7).cgColor
            let whiteColor = UIColor.baeminBackgroundWhite.cgColor
            
            gradientLayer.colors = [topColor, whiteColor, whiteColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0.0, 0.4, 1.0]
        }

        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    // MARK: - Setting Methods
    
    private func setStyle() {
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setUI() {
        self.addSubviews(locationButton, stackView, textField, imageView, specialPriceButton)
        stackView.addArrangedSubviews(benefitButton, notiButton, basketButton)
    }
    
    private func setLayout() {
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(locationButton.snp.bottom).offset(12)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(24)
            $0.leading.equalTo(textField)
        }
        
        specialPriceButton.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.leading.equalTo(textField)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

#Preview {
    HeaderView()
}

