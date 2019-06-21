//
//  Collection.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

extension Collection {
    
    public subscript (safe index: Index) -> Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
}
