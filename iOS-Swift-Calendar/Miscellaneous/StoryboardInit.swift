//
//  StoryboardInit.swift
//  Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

public protocol StoryboardInit { }

public extension StoryboardInit where Self: UIViewController {
    
    // MARK: - Storyboard Init
    
    static func storyboardInit() -> Self {
        
        // swiftlint:disable force_cast
        return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self)).instantiateInitialViewController() as! Self
        // swiftlint:enable force_cast
    }
}

public protocol ViewModelStoryboardInit: StoryboardInit {
    
    // MARK: - Types
    
    associatedtype ViewModel
    
    // MARK: - Variables
    
    var viewModel: ViewModel? { get set }
}

public extension ViewModelStoryboardInit where Self: UIViewController {
    
    // MARK: - View Model Storyboard Init
    
    static func storyboardInit(viewModel: ViewModel?) -> Self {
        
        var viewController = storyboardInit()
        viewController.viewModel = viewModel
        
        return viewController
    }
}
