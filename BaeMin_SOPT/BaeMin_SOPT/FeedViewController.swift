import UIKit

import SnapKit
import Then

final class FeedViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = HeaderView()
    private let categoryView = CategoryView()
    private let martView = MartView()
    private let bannerView = BannerView()
    private let rankingView = RankingView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setUI()
        setLayout()
    }

    // MARK: - Setup Methods
    
    private func setStyle() {
        view.backgroundColor = .baeminBackgroundWhite
        self.navigationController?.isNavigationBarHidden = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setUI() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(headerView, categoryView, martView, bannerView, rankingView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        martView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(martView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
        
        rankingView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

#Preview {
    FeedViewController()
}

