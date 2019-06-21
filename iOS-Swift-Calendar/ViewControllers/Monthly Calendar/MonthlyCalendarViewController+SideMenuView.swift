//
//  MonthlyCalendarViewController+SideMenuView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// MARK: - SideMenuViewDelegate

extension MonthlyCalendarViewController: SideMenuViewDelegate {
    
    func toggleHolidayOption(for country: Country, isSelected: Bool) {
        
        guard let viewModel = viewModel else {
            
            return
        }
        
        guard
            !(viewModel.holidayViewModels.compactMap { $0.country }).contains(country),
            isSelected
        else {
            
            if
                let holidayViewModel = (viewModel.holidayViewModels.first { $0.country ==  country })
            {
                
                holidayViewModel.isSelected = isSelected
            }
            
            calendarView.reloadData()
            
            return
        }
        
        fetchHolidays(for: country)
    }
    
    func didTapOnTransparentView() {
        
        sideMenuView.isUserInteractionEnabled = false
    }
}
