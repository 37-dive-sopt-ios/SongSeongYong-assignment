import UIKit

extension UIFont {
    // MARK: - Static Properties (새로운 방식)
    static let head_b_24: UIFont = UIFont(name: "Pretendard-Bold", size: 24) ?? .systemFont(ofSize: 24, weight: .bold)
    static let head_b_18: UIFont = UIFont(name: "Pretendard-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
    static let head_b_16: UIFont = UIFont(name: "Pretendard-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
    static let head_b_14: UIFont = UIFont(name: "Pretendard-Bold", size: 14) ?? .systemFont(ofSize: 14, weight: .bold)
    static let title_sb_18: UIFont = UIFont(name: "Pretendard-SemiBold", size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
    static let body_r_14: UIFont = UIFont(name: "Pretendard-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
    static let body_r_12: UIFont = UIFont(name: "Pretendard-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
    static let caption_r_10: UIFont = UIFont(name: "Pretendard-Regular", size: 10) ?? .systemFont(ofSize: 10, weight: .regular)
    
    // MARK: - 기존 방식 지원 (호환성)
    enum SuitStyle {
        case head_b_24
        case head_b_18
        case title_sb_18
        case body_r_14
        case caption_r_10
    }
    
    static func pretendard(_ style: SuitStyle) -> UIFont {
        switch style {
        case .head_b_24: return .head_b_24
        case .head_b_18: return .head_b_18
        case .title_sb_18: return .title_sb_18
        case .body_r_14: return .body_r_14
        case .caption_r_10: return .caption_r_10
        }
    }
}
