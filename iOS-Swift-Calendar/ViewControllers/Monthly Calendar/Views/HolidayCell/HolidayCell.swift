//
//  HolidayCell.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/17.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

final class HolidayCell: UITableViewCell, NibLoadableView {
    
    // NARK: IBOutlets
    
    @IBOutlet private weak var eventLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
}

// MARK: Helper Functions

extension HolidayCell {
    
    private func setupUI() {
    
        selectionStyle = .none
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    func setup(with holiday: Holiday) {
        
        backgroundColor = holiday.country?.color
        eventLabel.text = holiday.name
    }
}
