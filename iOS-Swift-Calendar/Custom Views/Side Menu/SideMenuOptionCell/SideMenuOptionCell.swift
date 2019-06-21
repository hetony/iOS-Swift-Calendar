//
//  SideMenuViewOptionCell.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

class SideMenuOptionCell: UITableViewCell, NibLoadableView {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Variables
    
    var viewModel: SideMenuOptionCellViewModel?

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
       
        backgroundColor = selected ? Colors.General.selectedCellBackground : Colors.General.background
        iconImageView.tintColor = selected ? Colors.General.active : Colors.General.inactive
        
        viewModel?.isSelected = selected
    }
    
    func setup(viewModel: SideMenuOptionCellViewModel) {
        
        titleLabel.text = viewModel.option.title
        iconImageView.image = viewModel.option.icon
        
        selectionStyle = .none
        
        self.viewModel = viewModel
    }
    
    func toggleCheckbox() {
        
        guard let viewModel = viewModel else {
            
            return
        }
        
        viewModel.isSelected.toggle()
        
        iconImageView.image = viewModel.isSelected ?
            UIImage(named: "menu_checked_checkbox_icon") :
            UIImage(named: "menu_unchecked_checkbox_icon")
    }
}
