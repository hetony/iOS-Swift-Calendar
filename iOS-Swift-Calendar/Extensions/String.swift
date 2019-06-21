//
//  String.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Date format
    
    public func date(
        with format: String,
        timeZone: TimeZone? = .current
    ) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .current
        dateFormatter.timeZone = timeZone
        
        return dateFormatter.date(from: self)
    }
}
