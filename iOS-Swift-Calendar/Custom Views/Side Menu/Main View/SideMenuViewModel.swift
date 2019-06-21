//
//  SideMenuViewModel.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

final class SideMenuViewModel {
    
    // MARK: Variables
    
    lazy var menuSections: [MenuSectionType] = {
        
        return [
            .view(options: [.month]),
            .show(options: [.holidays(country: .tw), .holidays(country: .us)])
        ]
    }()
    
    var selectedShowItem = [MenuShowOption]()
    
    func append(showOption: MenuShowOption) {
        
        selectedShowItem.append(showOption)
    }
    
    func remove(showOption: MenuShowOption) {
        
        selectedShowItem.removeAll { $0.title == showOption.title }
    }
}
