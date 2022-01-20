//
//  Styler.swift
//  LoginApp
//
//  Created by Rohit Valiveti on 1/20/22.
//

import Foundation
import UIKit

class Styler{
    
    static func makeBottomLine() -> CALayer {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.systemMint.cgColor
        bottomLine.frame = CGRect(x: 0, y: 40, width: 310, height: 2)
        return bottomLine
    }
    
    
}
