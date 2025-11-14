import UIKit

import SnapKit
import Then

final class MartView: UIView {
    
    // MARK: - Properties
    
    let martCategories = ["B마트", "CU", "이마트슈퍼", "홈플러스", "GS25",
                          "이마트", "롯데마트", "코스트코"]
    let martImages: [UIImage?] = [
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza")
    ]
    
    private let cellHeight: CGFloat
    
    // MARK: - UI Components
    
    private let martCollectionView: UICollectionView
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        let labelFont = UIFont.body_r_14
        let labelHeight = "A".size(withAttributes: [.font: labelFont]).height
        cellHeight = 58 + 6 + labelHeight
        
        let layout = UICollectionViewFlowLayout()
        martCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        do {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
            
            martCollectionView.backgroundColor = .white
            martCollectionView.showsHorizontalScrollIndicator = false
            martCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
            martCollectionView.dataSource = self
            martCollectionView.delegate = self
        }
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    
    private func setUI() {
        addSubview(martCollectionView)
    }
    
    private func setLayout() {
        martCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(cellHeight + 22)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MartView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return martCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.identifier,
            for: indexPath
        ) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let title = martCategories[indexPath.item]
        let image = martImages[indexPath.item]
        
        cell.configure(with: title, image: image)
        return cell
    }
}

extension MartView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 58
        return CGSize(width: cellWidth, height: self.cellHeight)
    }
}

#Preview {
    MartView()
}

