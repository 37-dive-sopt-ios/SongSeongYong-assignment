import UIKit

import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FoodCategoryCell"
  
    // MARK: - UI Components
    
    private let foodImageView: UIImageView
    private let categoryLabel: UILabel
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        foodImageView = UIImageView()
        categoryLabel = UILabel()
        
        super.init(frame: frame)
        
        do {
            foodImageView.contentMode = .scaleAspectFit
            foodImageView.layer.cornerRadius = 20
            foodImageView.backgroundColor = .baeminBackgroundWhite
            foodImageView.clipsToBounds = true
        }
        
        do {
            categoryLabel.font = .body_r_14
            categoryLabel.textColor = .baeminBlack
            categoryLabel.text = "한그릇"
        }
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    
    private func setUI() {
        addSubviews(foodImageView, categoryLabel)
    }
    
    private func setLayout() {
        foodImageView.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.size.equalTo(58)
        }
        
        categoryLabel.snp.makeConstraints{
            $0.top.equalTo(foodImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
}

extension CategoryCell {
    public func configure(with categoryName: String, image: UIImage?) {
        categoryLabel.text = categoryName
        foodImageView.image = image
    }
}

