//
//  SideMenuView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/14.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

protocol SideMenuViewDelegate: class {
    
    func toggleHolidayOption(for country: Country, isSelected: Bool)
}

final class SideMenuView: UIView, NibLoadableView {
    
    // MARK: Constants
    
    static let cellHeight: CGFloat = 50
    static let hideScrollViewTranslationX: CGFloat = -500
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var transparentView: UIView!
    
    // MARK: Variables
    
    var viewModel: SideMenuViewModel?
    weak var delegate: SideMenuViewDelegate?
    var isInit = true
    
    private var scrollViewOriginalPosition: CGPoint?
    private var scrollViewCurrentPositionTouched: CGPoint?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        prepareForStoryboardUsage()
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepareForStoryboardUsage()
        setupUI()
    }
}

// MARK: - Helper Functions

private extension SideMenuView {
    
    private func setupUI() {
        
        // Scroll view
        
        scrollView.transform = CGAffineTransform(
            translationX: SideMenuView.hideScrollViewTranslationX,
            y: 0
        )
        
        // TableView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        
        tableView.registerHeader(SideMenuSectionHeaderView.self)
        tableView.register(SideMenuOptionCell.self)
        
        // TransparentView
        
        transparentView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tapOnTransparentView)
            )
        )
    }
}

// MARK: Actions

private extension SideMenuView {
    
    @objc func tapOnTransparentView() {
        
        hide()
    }
}

// MARK: Helper Functions

extension SideMenuView {
    
    func show() {
        
        UIView.animate(withDuration: 0.5) {
            self.scrollView.transform = CGAffineTransform(
                translationX: 0,
                y: 0
            )
        }
        
        transparentView.isHidden = false
        isUserInteractionEnabled = true
    }
    
    func hide(hiddenWidth: CGFloat = 0) {
        
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.scrollView.transform = CGAffineTransform(
                translationX: (SideMenuView.hideScrollViewTranslationX + hiddenWidth),
                y: 0
            )
        }) { [weak self] _ in
            
            
            self?.transparentView.isHidden = true
        }
    }
}
