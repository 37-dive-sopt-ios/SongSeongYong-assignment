//
//  FontLiterals.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 10/16/25.
//
import UIKit


enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardExtraBold = "Pretendard-ExtraBold"
}
 
extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    
    /// pretendardSemiBold 18
    @nonobjc class var h1: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 18)
    }
    
    ///pretendardExtraBold 30
    @nonobjc class var h2: UIFont {
        return UIFont.font(.pretendardExtraBold, ofSize: 30)
    }
    
    @nonobjc class var h3: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
}
