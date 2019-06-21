//
//  HolidayDetailViewController+UIPickerView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// MARK: UIPickerViewDelegate

extension HolidayDetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerViewOptions[safe: row]?.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let option = pickerViewOptions[safe: row] else {
            
            return
        }
        
        notificationLabel.text = option.title
    }
}

// MARK: UIPickerViewDataSource

extension HolidayDetailViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
}
