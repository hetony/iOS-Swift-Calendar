//
//  AppDelegate.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initial View Controller
        
        configureInitialViewController()
        
        // Request Authorization for Notification
        
        requestNotificationAuthorization()
        
        return true
    }
}

private extension AppDelegate {
    
    func configureInitialViewController() {
        
        let monthlyCalendarViewModel = MonthlyCalendarViewModel()
        monthlyCalendarViewModel.calendarType = .month
       
        let rootViewController = MonthlyCalendarViewController.storyboardInit(
            viewModel: monthlyCalendarViewModel
        )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
    
    func requestNotificationAuthorization() {
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { (_, _) in }
        
        UNUserNotificationCenter.current().delegate = self
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate { }
