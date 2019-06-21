//
//  Notification.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import Foundation
import RealmSwift

final class Notification {
    
    let id: String
    let notificationTimeOption: NotificationTimeOption
    
    init(
        id: String,
        notificationTimeOption: NotificationTimeOption
    ) {
        
        self.id = id
        self.notificationTimeOption = notificationTimeOption
    }
}

final class PersistableNotification: Object {
  
    @objc dynamic var id: String = ""
    @objc dynamic var notificationTimeOptionRawValue: TimeInterval = NotificationTimeOption.none.rawValue
    
    var notificationTimeOption: NotificationTimeOption {
        
        return NotificationTimeOption(rawValue: notificationTimeOptionRawValue) ?? .none
    }
    
    override public static func primaryKey() -> String? {
        
        return "id"
    }
}
