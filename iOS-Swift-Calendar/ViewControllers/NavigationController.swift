//
//  NavigationController.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
    }

    public func setupNavigationBar() {
        
        navigationBar.tintColor = Colors.General.navigationBarText
                
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
