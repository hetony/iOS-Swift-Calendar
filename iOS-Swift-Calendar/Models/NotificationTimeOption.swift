//
//  NotificationTimeOption.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

enum NotificationTimeOption: TimeInterval {
    
    case none = 0
    case oneDay = 86400
    case oneHour = 3600
    case thirtyMins = 1800
    case tenMins = 600
    
    var title: String {
        switch self {
        case .none:
            
            return "No notification"
        case .oneDay:
            
            return "One day before"
        case .oneHour:
            
            return "One hour before"
        case .thirtyMins:
            
            return "30 minutes before"
        case .tenMins:
            
            return "10 minutes before"
        }
    }
}
