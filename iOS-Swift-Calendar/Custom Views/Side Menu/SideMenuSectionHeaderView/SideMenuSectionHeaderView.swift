//
//  SideMenuSectionHeaderView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee. on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

final class SideMenuSectionHeaderView: UITableViewHeaderFooterView, NibLoadableView {
   
    @IBOutlet weak private var titleLabel: UILabel!

    func setup(title: String) {
        
       titleLabel.text = title
    }
}
