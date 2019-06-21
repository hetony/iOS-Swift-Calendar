//
//  MonthlyCalendarViewController+JTAppleCalendar.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/18.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit
import JTAppleCalendar

// MARK: - JTAppleCalendarViewDelegate

extension MonthlyCalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        return
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        guard let cell: CalendarCell = calendar.dequeue(for: indexPath) else {
            
            return JTAppleCell()
        }
        
        cell.setup(
            with: cellState,
            holidays: viewModel?.getHolidays(for: date) ?? []
        )
        cell.delegate = self
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        
        return Calendar.current.isDateInToday(date)
    }
    
    func calendarDidScroll(_ calendar: JTAppleCalendarView) {
        
        guard
            let date = calendar.visibleDates().monthDates.first?.date
        else {
            
            return
        }
        
        navigationView.setupDateLabel(with: date)
    }
}

// MARK: - JTAppleCalendarViewDataSource

extension MonthlyCalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let oneYearInterval: TimeInterval = 60 * 60 * 24 * 365
        
        let startDate = Date() - oneYearInterval * 10
        let endDate = Date() + oneYearInterval * 10
        
        return ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: viewModel?.calendarType.row ?? 0,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            hasStrictBoundaries: true
        )
    }
}
