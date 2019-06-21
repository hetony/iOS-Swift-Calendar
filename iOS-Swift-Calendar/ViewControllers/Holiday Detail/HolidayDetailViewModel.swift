//
//  HolidayDetailViewModel.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation

final class HolidayDetailViewModel {
    
    let holiday: Holiday
    let notificationManager = NotificationManager()
   
    lazy var items: [HolidayDetailItem] = {
        
        return [
            HolidayDetailItem.time(date: self.holiday.date ?? Date()),
            HolidayDetailItem.description(content: self.holiday.description),
        ]
    }()
    
    var notificationTimeOption: NotificationTimeOption = .none
    
    init(holiday: Holiday) {
        
        self.holiday = holiday
        
        self.getNotificationTimeOption()
    }
    
    func createNotification(completion: @escaping ((Error?) -> Void)) {
        
        notificationManager.removeNotification(for: holiday)
        
        notificationManager.createNotification(
            for: holiday,
            notificationTimeOption: notificationTimeOption,
            completion: completion
        )
    }
    
    func getNotificationTimeOption() {
        
        notificationTimeOption = notificationManager.getNotificationTimeOption(for: holiday) ?? .none
    }
}
