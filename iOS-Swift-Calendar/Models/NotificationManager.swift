//
//  NotificationManager.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation
import UserNotifications
import RealmSwift

class NotificationManager {
    
    func createNotification(
        for holiday: Holiday,
        notificationTimeOption: NotificationTimeOption,
        completion: @escaping ((Error?) -> Void)
    ) {
        
        guard
            let holidayDate = holiday.date,
            notificationTimeOption != .none
        else {
            
            completion(NotificationError.setNoNotification)
            
            return
        }
    
        let timeInterval = (holidayDate.timeIntervalSinceNow - notificationTimeOption.rawValue)
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInterval,
            repeats: false
        )
        
        var flag: String = ""
        
        switch holiday.country {
        case .tw?:
        
            flag = "🇹🇼"
        case .us?:
            
            flag = "🇺🇸"
        default:
            
            break
        }
        
        let content = UNMutableNotificationContent()
        content.title = (holiday.name + flag)
        content.subtitle = holiday.dateString
        content.body = holiday.description
        content.sound = UNNotificationSound.default
        
        let id = createNotificationID(for: holiday)
        
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            
            if error == nil {
            
                // Save to realm
                
                let persistableNotification = PersistableNotification()
                persistableNotification.id = id
                persistableNotification.notificationTimeOptionRawValue = notificationTimeOption.rawValue
                
                DispatchQueue(label: "background").async {
                    autoreleasepool {
                        
                        do {
                            
                            let realm = try Realm()
                            
                            try realm.write {
                                
                                realm.add(persistableNotification, update: true)
                            }
                        } catch {
                            
                            completion(error)
                            
                            return
                        }
                    }
                }                
            }
            
            completion(error)
        }
    }
    
    func removeNotification(for holiday: Holiday) {
        
        let notificationID = createNotificationID(for: holiday)
        
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
    
    func getNotificationTimeOption(for holiday: Holiday) -> NotificationTimeOption? {
        
        let notificationID = createNotificationID(for: holiday)
        
        guard let realm = try? Realm() else {
            
            return nil
        }
        
        return
            (realm.objects(PersistableNotification.self)
                .first { $0.id ==  notificationID })?
                .notificationTimeOption
    }
    
    private func createNotificationID(for holiday: Holiday) -> String {
        
        let country = holiday.country?.rawValue ?? ""

        return "\(holiday.name)_\(country)_\(holiday.dateString)_\(holiday.description)"
    }
}

enum NotificationError: Error {
    
    case setNoNotification
}
