//
//  addSubviewExtension.swift
//  sopt_37th_1weekSeminar
//
//  Created by 송성용 on 10/31/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
