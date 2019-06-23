//
//  HolidaysService.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/17.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

final class HolidayService {
    
    func fetchHolidays(for country: Country) throws -> [Holiday] {
        
        guard
            let path = Bundle.main.path(
                forResource: country.resourceName,
                ofType: "json"
            ),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            !data.isEmpty
        else {
            
            throw HolidayError.noDate
        }
        
        let holidaysFromData = try JSONDecoder().decode([Holiday].self, from: data)
        
        return holidaysFromData.map {
            
            return Holiday(
                name: $0.name,
                description: $0.description,
                dateString: $0.dateString,
                country: country
            )
        }
    }
}

enum HolidayError: Error {
    
    case noDate
}
