//
//  Extensions.swift
//  Wipro
//
//  Created by hb on 09/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit

extension CGRect {
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var fontRatio:CGFloat {
        let ratio = screenWidth / 320
        return ratio > 1.3 ? 1.3 : ratio
    }
}
