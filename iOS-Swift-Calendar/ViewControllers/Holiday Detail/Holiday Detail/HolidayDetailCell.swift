//
//  HolidayDetailCell.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

final class HolidayDetailCell: UITableViewCell, NibLoadableView {
    
    // MARK: IBOulets
    
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var contentLabel: UILabel!
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
    }
}

extension HolidayDetailCell {
    
    func setup(with item: HolidayDetailItem) {
        
        iconImageView.image = item.icon

        switch item {
        case .time(let date):
            
            contentLabel.text = "\(date.string(with: "yyyy/MM/dd"))"
        case .description(let content):
            
            contentLabel.text = content
        }
    }
}
