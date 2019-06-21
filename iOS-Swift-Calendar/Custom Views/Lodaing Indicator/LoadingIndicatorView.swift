//
//  LoadingIndicatorView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

final class LoadingIndicatorView: UIView, NibLoadableView {

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
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

private extension LoadingIndicatorView {
    
    func setupUI() {
        
        activityIndicator.startAnimating()
    }
}
