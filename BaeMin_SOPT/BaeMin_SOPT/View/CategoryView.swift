import UIKit

import SnapKit
import Then

final class CategoryView: UIView {
    
    // MARK: - Properties
    
    let categories = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택모아보기"]
    let foodCategories = ["한그릇", "치킨", "카페·디저트", "피자", "분식",
                              "고기", "찜·탕", "야식", "패스트푸드", "픽업"]
    let foodCategoryImages: [UIImage?] = [
        UIImage(named: "bossam"), UIImage(named: "pizza"), 
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza"),
        UIImage(named: "bossam"), UIImage(named: "pizza")
    ]
    
    private var selectedUnderlineViewLeadingConstraint: Constraint?
    private var selectedUnderlineViewWidthConstraint: Constraint?
    private var categoryButtons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    // MARK: - UI Components
    
    private let categoryScrollView: UIScrollView
    private let contentStackView: UIStackView
    private let selectedUnderlineView: UIView
    private let underlineView: UIView
    private let categoryCollectionView: UICollectionView
    private let bottomUnderlineView: UIView
    private let moreButton: UIButton
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        categoryScrollView = UIScrollView()
        contentStackView = UIStackView()
        selectedUnderlineView = UIView()
        underlineView = UIView()
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bottomUnderlineView = UIView()
        moreButton = UIButton(type: .custom)
        
        super.init(frame: frame)
        
        do {
            categoryScrollView.showsHorizontalScrollIndicator = false
        }
        
        do {
            contentStackView.axis = .horizontal
            contentStackView.spacing = 18
            contentStackView.alignment = .center
        }
        
        do {
            selectedUnderlineView.backgroundColor = .baeminBlack
        }
        
        do {
            underlineView.backgroundColor = .baeminGray200
        }
        
        do {
            layout.minimumLineSpacing = 16
            
            categoryCollectionView.backgroundColor = .white
            categoryCollectionView.isScrollEnabled = false
            categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
            categoryCollectionView.dataSource = self
            categoryCollectionView.delegate = self
        }
        
        do {
            bottomUnderlineView.backgroundColor = .baeminBackgroundWhite
        }
        
        do {
            moreButton.configuration = .plain()
            var part1Attributes = AttributeContainer()
            part1Attributes.font = .head_b_14
            part1Attributes.foregroundColor = .baeminBlack
            var part2Attributes = AttributeContainer()
            part2Attributes.font = .body_r_14
            part2Attributes.foregroundColor = .baeminBlack
            
            let part1 = AttributedString("음식배달", attributes: part1Attributes)
            let part2 = AttributedString("에서 더보기", attributes: part2Attributes)
            
            moreButton.configuration?.attributedTitle = part1 + part2
            moreButton.configuration?.image = .chevronRight
            moreButton.configuration?.imagePlacement = .trailing
            moreButton.configuration?.imagePadding = 4
            moreButton.configuration?.baseForegroundColor = .baeminBlack
            moreButton.configuration?.contentInsets = .zero
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
        layoutIfNeeded()
        self.updateUnderlinePosition(animated: false)
    }
    
    // MARK: - Setting Methods
    
    private func setStyle() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setUI() {
        addSubviews(categoryScrollView, underlineView, selectedUnderlineView, categoryCollectionView, bottomUnderlineView, moreButton)
        categoryScrollView.addSubview(contentStackView)
        createCategoryButtons()
    }
    
    private func setLayout() {
        categoryScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(categoryScrollView)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        selectedUnderlineView.snp.makeConstraints {
            $0.centerY.equalTo(underlineView)
            $0.height.equalTo(3)
            self.selectedUnderlineViewLeadingConstraint = $0.leading.equalToSuperview().constraint
            self.selectedUnderlineViewWidthConstraint = $0.width.equalTo(0).constraint
        }
        
        let labelFont = UIFont.body_r_14
        let labelHeight = "A".size(withAttributes: [.font: labelFont]).height
        let cellHeight = 58 + 6 + labelHeight
        let lineSpacing: CGFloat = 16
        let numberOfRows: CGFloat = 2
        let collectionViewHeight = (cellHeight * numberOfRows) + (lineSpacing * (numberOfRows - 1))
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(collectionViewHeight)
        }
        
        bottomUnderlineView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        moreButton.snp.makeConstraints{
            $0.top.equalTo(bottomUnderlineView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func createCategoryButtons() {
        for (index, category) in categories.enumerated() {
            let button = UIButton(type: .custom).then {
                $0.setTitle(category, for: .normal)
                $0.titleLabel?.font = .head_b_18
                $0.setTitleColor(UIColor.baeminGray300, for: .normal)
                $0.setTitleColor(UIColor.baeminBlack, for: .selected)
                $0.tag = index
                $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
            }
            
            if index == 0 {
                button.isSelected = true
            }
            
            categoryButtons.append(button)
            contentStackView.addArrangedSubview(button)
        }
        
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        contentStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        let newIndex = sender.tag
        guard newIndex != selectedIndex else { return }
        categoryButtons[selectedIndex].isSelected = false
        sender.isSelected = true
        selectedIndex = newIndex
        updateUnderlinePosition(animated: true)
        
        self.categoryCollectionView.reloadData()
        let shouldShowBottomViews = (newIndex == 0)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
            self.bottomUnderlineView.alpha = shouldShowBottomViews ? 1.0 : 0.0
            self.moreButton.alpha = shouldShowBottomViews ? 1.0 : 0.0
        }
        
        self.bottomUnderlineView.isUserInteractionEnabled = shouldShowBottomViews
        self.moreButton.isUserInteractionEnabled = shouldShowBottomViews
    }
    
    private func updateUnderlinePosition(animated: Bool) {
        guard selectedIndex < categoryButtons.count else { return }
        let selectedButton = categoryButtons[selectedIndex]
        guard let titleLabel = selectedButton.titleLabel else { return }
        let newWidth = titleLabel.frame.width
        let newLeading = titleLabel.convert(titleLabel.bounds, to: self).origin.x
        let animationDuration = animated ? 0.3 : 0.0
        
        self.selectedUnderlineViewLeadingConstraint?.update(offset: newLeading)
        self.selectedUnderlineViewWidthConstraint?.update(offset: newWidth)
        
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
    }
}

extension UISegmentedControl {
    func removeBackgroundAndDivider() {
        let emptyImage = UIImage()
        self.setBackgroundImage(emptyImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(emptyImage, for: .selected, barMetrics: .default)
        self.setDividerImage(emptyImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selectedIndex == 0) ? foodCategories.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.identifier,
            for: indexPath
        ) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let title = foodCategories[indexPath.item]
        let image = foodCategoryImages[indexPath.item]
        
        cell.configure(with: title, image: image)
        return cell
    }
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 58
        let labelFont = UIFont.body_r_14
        let labelHeight = "A".size(withAttributes: [.font: labelFont]).height
        let cellHeight = 58 + 6 + labelHeight
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let totalWidth = collectionView.bounds.width
        let cellWidth: CGFloat = 58
        let numberOfCells: CGFloat = 5
        let totalSpacing = totalWidth - (cellWidth * numberOfCells)
        let numberOfGaps = numberOfCells - 1
        
        return max(0, totalSpacing / numberOfGaps)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

#Preview {
    CategoryView()
}

