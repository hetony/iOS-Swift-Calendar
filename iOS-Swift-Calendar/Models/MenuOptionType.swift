//
//  MenuOptionType.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/14.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

protocol MenuOption {
    
    var title: String { get }
    var icon: UIImage? { get }
}

enum MenuSectionType {
    
    case show(options: [MenuShowOption])
    case view(options: [MenuCalendarTypeOption])
    
    var title: String {
        switch self {
        case .show:
        
            return "Show"
        case .view:
            
            return "View"
        }
    }
    
    var options: [MenuOption] {
        switch self {
        case .show(let options):
            
            return options
        case .view(let options):
            
            return options
        }
    }
}

enum MenuCalendarTypeOption: String, MenuOption {
    
    case week = "Week"
    case month = "Month"
    
    var title: String {
        
        return rawValue
    }
    
    var icon: UIImage? {
        switch self {
        case .week:
            
            return UIImage(named: "menu_week_icon")
        case .month:
            
            return UIImage(named: "menu_month_icon")
        }
    }
    
    var row: Int {
        
        switch self {
        case .week:
            
            return 1
        case .month:
            
            return 6
        }
    }
}

enum MenuShowOption: MenuOption {
    
    case holidays(country: Country)
    
    var title: String {
        
        switch self {
        case .holidays(let country):
            
            return "\(country.rawValue) Holidays"
        }
    }
    
    var icon: UIImage? {
        
        return UIImage(named: "menu_unchecked_checkbox_icon")
    }
    
    var selectedIcon: UIImage? {
        
        return UIImage(named: "menu_checked_checkbox_icon")
    }
}

extension MenuShowOption: Equatable, Hashable {
    
    public static func == (lhs: MenuShowOption, rhs: MenuShowOption) -> Bool {
       
        switch (lhs, rhs) {
        case (.holidays(let lhsCountry), .holidays(let rhsCountry)):
            
            return lhsCountry == rhsCountry
        }
    }
}
