//
//  SideMenuOptionCellViewModel.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/16.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

final class SideMenuOptionCellViewModel {
    
    var option: MenuOption
    var isSelected: Bool = false
    
    init(option: MenuOption) {
        
        self.option = option
    }
}

