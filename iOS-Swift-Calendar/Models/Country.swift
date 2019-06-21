//
//  Country.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

enum Country: String {
    
    case tw = "Taiwan"
    case us = "US"
    
    var resourceName: String {
        
        switch self {
        case .tw:
            
            return "Taiwan_holidays"
        case .us:
            
            return "US_holidays"
        }
    }
    
    var timeZone: TimeZone? {
        
        switch self {
        case .tw:
            
            return TimeZone(abbreviation: "UTC+8")
        case .us:
            return TimeZone(abbreviation: "EDT")
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .tw:
            
            return UIColor(with: "#e6b725")
        case .us:
            
            return UIColor(with: "#cd3d3d")
        }
    }
}
