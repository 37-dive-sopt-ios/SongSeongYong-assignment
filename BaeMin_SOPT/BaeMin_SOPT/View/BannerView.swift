import UIKit

import SnapKit
import Then

final class BannerView: UIView {
    
    // MARK: - Properties
    
    private let bannerColors: [UIColor] = [
        .red,      
        .orange,
        .yellow,
        .green,
        .blue,
        .purple
    ]
    
    // MARK: - UI Components

    private let bannerCollectionView: UICollectionView

    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        do {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
            
            bannerCollectionView.backgroundColor = .white
            bannerCollectionView.showsHorizontalScrollIndicator = false
            bannerCollectionView.isPagingEnabled = true
            bannerCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
            bannerCollectionView.dataSource = self
            bannerCollectionView.delegate = self
        }
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    
    private func setStyle() {
        backgroundColor = .white
    }
    
    private func setUI() {
        addSubview(bannerCollectionView)
    }
    
    private func setLayout() {
        bannerCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(114)
            $0.bottom.equalToSuperview()
        }
    }
}

extension BannerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCell.identifier,
            for: indexPath
        ) as? BannerCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: bannerColors[indexPath.item])
        return cell
    }
}

extension BannerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

#Preview {
    BannerView()
}

