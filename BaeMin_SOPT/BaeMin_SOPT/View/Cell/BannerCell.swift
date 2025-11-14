import UIKit

import SnapKit
import Then

final class BannerCell: UICollectionViewCell {
    
    static let identifier = "BannerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with color: UIColor) {
        contentView.backgroundColor = color
    }
}

