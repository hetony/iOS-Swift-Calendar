//
//  MonthlyCalendarViewModel.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

final class MonthlyCalendarViewModel {
    
    // MARK: Variables
    
    let holidayService: HolidayService
    
    var holidayViewModels = [HolidayViewModel]()
    var calendarType: MenuCalendarTypeOption = .week
    
    // MARK: Init
    
    init(holidayService: HolidayService = HolidayService()) {
        
        self.holidayService = holidayService
    }
}

// MARK: Helper Functions

extension MonthlyCalendarViewModel {
    
    func fetchHolidays(
        for country: Country,
        completion: ((Result<[Holiday], Error>) -> Void)? = nil
    ) {
        
        do {
            
            let holidays = try holidayService.fetchHolidays(for: country)
            
            holidayViewModels.append(
                HolidayViewModel(holidays: holidays, country: country)
            )
            
            completion?(.success(holidays))
        } catch {
            
            completion?(.failure(error))
        }
    }
    
    func getHolidays(for date: Date) -> [Holiday] {
        
        return
            holidayViewModels
                .filter { $0.isSelected }
                .flatMap { $0.holidays }
                .filter { $0.date == date }
    }
}

// MARK: HolidayViewModel

final class HolidayViewModel {
    
    let holidays: [Holiday]
    let country: Country
    var isSelected: Bool = true
    
    init(holidays: [Holiday], country: Country) {
        
        self.holidays = holidays
        self.country = country
    }
}
