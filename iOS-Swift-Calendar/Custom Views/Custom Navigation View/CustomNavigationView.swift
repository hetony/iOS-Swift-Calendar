//
//  CustomNavigationView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

protocol CustomNavigationViewDelegate: class {
    
    func didTouchInsideUpMenuButton()
    func didTouchInsideUpTodayButton()
}

final class CustomNavigationView: UIView, NibLoadableView {
    
    // MARK: Constants
    
    private static let monthFormat = "MMMM yyyy"
    
    // MARK: IBOulets
    
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var todayButton: UIButton!
    @IBOutlet private weak var monthDateLabel: UILabel!
   
    // MARK: Variables
    
    weak var delegate: CustomNavigationViewDelegate?

    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepareForStoryboardUsage()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        prepareForStoryboardUsage()
        setupUI()
    }
}

// MARK: Setup UI

private extension CustomNavigationView {
    
    func setupUI() {
        
        menuButton.addTarget(
            self, action:
            #selector(touchInsideUpMenuButton),
            for: .touchUpInside
        )
        
        todayButton.addTarget(
            self, action:
            #selector(touchInsideUpTodayButton),
            for: .touchUpInside
        )
    }
}

// MARK: Actions

private extension CustomNavigationView {
    
    @objc func touchInsideUpMenuButton() {
        
        delegate?.didTouchInsideUpMenuButton()
    }
    
    @objc func touchInsideUpTodayButton() {
        
        delegate?.didTouchInsideUpTodayButton()
    }
}

// MARK: Helper Functions

extension CustomNavigationView {
    
    func setupDateLabel(with date: Date) {
        
        monthDateLabel.text = date.string(with: CustomNavigationView.monthFormat)
    }
}
