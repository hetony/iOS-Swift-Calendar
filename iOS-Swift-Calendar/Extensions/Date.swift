//
//  String.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/16.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

extension Date {
    
    public func string(
        with format: String,
        timeZone: TimeZone? = .current,
        locale: Locale? = .current
    ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        
        return dateFormatter.string(from: self)
    }
}
