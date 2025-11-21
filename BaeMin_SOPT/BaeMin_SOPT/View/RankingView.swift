import UIKit

import SnapKit
import Then

final class RankingView: UIView {
    
    // MARK: - Properties
    
    private let rankingImages: [UIImage?] = [
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam")
    ]
    
    // MARK: - UI Components
    
    private let rankingLabel: UILabel
    private let infoImageView: UIImageView
    private let wholeButton: UIButton
    private let rankingCollectionView: UICollectionView
    private let gradientLayer: CAGradientLayer
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        rankingLabel = UILabel()
        infoImageView = UIImageView()
        wholeButton = UIButton(type: .system)
        
        let layout = UICollectionViewFlowLayout()
        rankingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        gradientLayer = CAGradientLayer()
        
        super.init(frame: frame)
        
        do {
            rankingLabel.font = .title_sb_18
            rankingLabel.textColor = .white
            rankingLabel.text = "우리 동네 한그릇 인기 랭킹"
        }
        
        do {
            infoImageView.contentMode = .scaleAspectFit
            infoImageView.image = UIImage(resource: .infoIcon).withRenderingMode(.alwaysTemplate)
            infoImageView.tintColor = .white
        }
        
        do {
            var config = UIButton.Configuration.plain()
            
            var titleAttr = AttributedString("전체보기")
            titleAttr.font = .head_b_16
            config.attributedTitle = titleAttr
            
            config.image = UIImage(resource: .chevronRight).withRenderingMode(.alwaysTemplate)
            config.imagePlacement = .trailing
            config.imagePadding = 4
            config.baseForegroundColor = .white
            config.contentInsets = .zero
            
            wholeButton.configuration = config
        }
        
        do {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 16
            layout.itemSize = CGSize(width: 145, height: 270)
            
            rankingCollectionView.backgroundColor = .clear
            rankingCollectionView.showsHorizontalScrollIndicator = false
            rankingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            rankingCollectionView.register(RankingCell.self, forCellWithReuseIdentifier: RankingCell.identifier)
            rankingCollectionView.dataSource = self
        }
        
        do {
            let topColor = UIColor.baeminBackgroundPurple.cgColor
            let whiteColor = UIColor.white.cgColor
            
            gradientLayer.colors = [topColor, whiteColor, whiteColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.locations = [0.0, 0.5, 1.0]
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
        addSubviews(rankingLabel, infoImageView, wholeButton, rankingCollectionView)
    }
    
    private func setLayout() {
        rankingLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoImageView.snp.makeConstraints{
            $0.centerY.equalTo(rankingLabel)
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(3)
            $0.size.equalTo(16)
        }
        
        wholeButton.snp.makeConstraints {
            $0.centerY.equalTo(rankingLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        rankingCollectionView.snp.makeConstraints{
            $0.top.equalTo(rankingLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(270)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension RankingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RankingCell.identifier,
            for: indexPath
        ) as? RankingCell else {
            return UICollectionViewCell()
        }
        
        let image = rankingImages[indexPath.item]
        cell.configure(with: image)
        
        return cell
    }
}

#Preview {
    RankingView()
}

