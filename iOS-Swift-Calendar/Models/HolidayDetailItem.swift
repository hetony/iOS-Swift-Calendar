//
//  HolidayDetailItem.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation
import UIKit

enum HolidayDetailItem {
    
    case time(date: Date)
    case description(content: String)
    
    var icon: UIImage? {
        switch self {
        case .time:
            
            return UIImage(named: "holiday_detail_item_time_icon")
        case .description:
            
            return UIImage(named: "holiday_detail_item_description_icon")
        }
    }
}
