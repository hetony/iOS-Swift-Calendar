//
//  File.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/17.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

class Holiday: Decodable {
    
    var name: String
    var description: String
    var dateString: String
    var date: Date? {
        
        return dateString.date(with: "yyyy/MM/dd")
    }
    var country: Country?
    
    init(
        name: String,
        description: String,
        dateString: String,
        country: Country?
    ) {
        
        self.name = name
        self.description = description
        self.dateString = dateString
        self.country = country
    }
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        case name, description
        case dateString = "date"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        dateString = try values.decode(String.self, forKey: .dateString)
        description = try values.decode(String.self, forKey: .description)
    }
}
