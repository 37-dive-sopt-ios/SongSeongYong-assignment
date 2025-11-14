import UIKit

import SnapKit
import Then

class RankingCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RankingCell"
    
    // MARK: - UI Components
    
    private let mainImageView: UIImageView
    private let storeNameLabel: UILabel
    private let starImageView: UIImageView
    private let ratingLabel: UILabel
    private let reviewCountLabel: UILabel
    private let itemNameLabel: UILabel
    private let discountLabel: UILabel
    private let priceLabel: UILabel
    private let originalPriceLabel: UILabel
    private let minOrderLabel: UILabel
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        mainImageView = UIImageView()
        storeNameLabel = UILabel()
        starImageView = UIImageView()
        ratingLabel = UILabel()
        reviewCountLabel = UILabel()
        itemNameLabel = UILabel()
        discountLabel = UILabel()
        priceLabel = UILabel()
        originalPriceLabel = UILabel()
        minOrderLabel = UILabel()
        
        super.init(frame: frame)
        
        do {
            mainImageView.backgroundColor = .baeminGray200
            mainImageView.contentMode = .scaleAspectFill
            mainImageView.clipsToBounds = true
            mainImageView.layer.cornerRadius = 8
        }
        
        do {
            storeNameLabel.text = "백억보쌈제육..."
            storeNameLabel.font = .body_r_12
            storeNameLabel.textColor = .baeminGray600
        }
        
        do {
            starImageView.image = UIImage(resource: .star)
            starImageView.contentMode = .scaleAspectFit
        }
        
        do {
            ratingLabel.text = "5.0"
            ratingLabel.font = .body_r_12
            ratingLabel.textColor = .baeminGray600
        }
        
        do {
            reviewCountLabel.text = "(1,973)"
            reviewCountLabel.font = .body_r_12
            reviewCountLabel.textColor = .baeminGray600
        }
        
        do {
            itemNameLabel.text = "[든든한 한끼] 보쌈 막국수"
            itemNameLabel.font = .body_r_14
            itemNameLabel.textColor = .baeminBlack
            itemNameLabel.numberOfLines = 1
        }
        
        do {
            discountLabel.text = "25%"
            discountLabel.font = .head_b_14
            discountLabel.textColor = .baeminRed
        }
        
        do {
            priceLabel.text = "12,000원"
            priceLabel.font = .head_b_14
            priceLabel.textColor = .baeminBlack
        }
        
        do {
            let text = "16,000원"
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
            originalPriceLabel.attributedText = attributeString
            originalPriceLabel.font = .body_r_12
            originalPriceLabel.textColor = .baeminGray600
        }
        
        do {
            minOrderLabel.text = "최소주문금액 없음"
            minOrderLabel.font = .head_b_14
            minOrderLabel.textColor = .baeminPurple
        }
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    
    private func setUI() {
        addSubviews(mainImageView, storeNameLabel, starImageView,
                    ratingLabel, reviewCountLabel, itemNameLabel,
                    discountLabel, priceLabel, originalPriceLabel,
                    minOrderLabel)
    }
    
    private func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.size.equalTo(145)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(9)
            $0.leading.equalTo(mainImageView)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalTo(storeNameLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(storeNameLabel)
            $0.size.equalTo(10)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(storeNameLabel)
        }
        
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(storeNameLabel)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(discountLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(discountLabel)
        }
        
        originalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        
        minOrderLabel.snp.makeConstraints {
            $0.top.equalTo(originalPriceLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    public func configure(with image: UIImage?) {
        mainImageView.image = image
    }
}

#Preview {
    RankingCell()
}

