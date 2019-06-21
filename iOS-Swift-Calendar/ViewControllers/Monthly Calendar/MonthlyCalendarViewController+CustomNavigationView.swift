//
//  MonthlyCalendarViewController+CustomNavigationView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// MARK: CustomNavigationViewDelegate

extension MonthlyCalendarViewController: CustomNavigationViewDelegate {
    
    func didTouchInsideUpMenuButton() {
        
        sideMenuView.show()
    }
    
    func didTouchInsideUpTodayButton() {

        calendarView.selectDates([Date()])
        calendarView.reloadData()
        calendarView.scrollToDate(Date())
    }
}
