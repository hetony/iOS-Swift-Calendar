//
//  Colors.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/14.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// swiftlint:disable nesting

public struct Colors {
    
    
    public struct General {
        
        static let active = UIColor(with: "3274FF")
        static let inactive = UIColor(with: "87878C")
        static let text = UIColor(with: "333333")
        static let background = UIColor.white
        static let lightText = UIColor(with: "A5A5AF")
        static let border = UIColor(with: "E9E9E9")
        static let destructive = UIColor(with: "FF3B30")
        static let selectedCellBackground = UIColor(with: "F0F3FF")
        public static let navigationBarText = UIColor(with: "62676D")
    }
}

// swiftlint:enable nesting

extension UIColor {
    
    // MARK: - Hex to UIColor
    
    public convenience init(with hexString: String) {
        
        let hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let redConstant = Int(color >> 16) & mask
        let greenConstant = Int(color >> 8) & mask
        let blueConstant = Int(color) & mask
        
        let red   = CGFloat(redConstant) / 255
        let green = CGFloat(greenConstant) / 255
        let blue  = CGFloat(blueConstant) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // MARK: - UIColor to Hex
    
    public var hexString: String {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        
        return NSString(format: "%06x", rgb).uppercased
    }
}
