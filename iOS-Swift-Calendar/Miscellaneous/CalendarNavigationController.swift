//
//  CalendarNavigationController.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

protocol CalendarNavigationDelegate: class {
    
    func didTouchUpInsideTodayCalendarButton()
    func didTouchUpInsideMenuButton()
}

final class CalendarNavigationController: UINavigationController {
    
    // MARK: - Variables
    
    weak var calendarNavigatioDelegate: CalendarNavigationDelegate?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
       
        super.viewDidLoad()

        setupNavigationBar()
    }
}

private extension CalendarNavigationController {
    
    func setupNavigationBar() {
    
        // Remove bottom border line
        
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
