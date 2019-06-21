//
//  UIViewController.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/18.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static let loadingIndicatorViewTag = 888888
    
    var loadingIndicatorView: UIView? {
        
        return view.viewWithTag(UIViewController.loadingIndicatorViewTag)
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
       
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: handler
            )
        )
        
        present(alert, animated: true)
    }
    
    func showLoadingIndicator() {
        
        DispatchQueue.main.async {
            
            if let loadingIndicatorView = self.loadingIndicatorView {
                
                loadingIndicatorView.isHidden = false
                
                return
            }
            
            let loadingIndicatorView = LoadingIndicatorView(frame: .zero)
            loadingIndicatorView.tag = UIViewController.loadingIndicatorViewTag
            self.view.addSubview(loadingIndicatorView)
            loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            
            loadingIndicatorView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor)
                .isActive = true
            
            loadingIndicatorView
                .topAnchor
                .constraint(equalTo: self.view.topAnchor)
                .isActive = true
            
            loadingIndicatorView
                .centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor)
                .isActive = true
            
            loadingIndicatorView
                .centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor)
                .isActive = true
        }
    }
    
    func hideLoadingIndicator() {
        
        DispatchQueue.main.async {
            
            guard let loadingIndicatorView = self.loadingIndicatorView else {
                
                return
            }
            
            loadingIndicatorView.isHidden = true
        }
    }
    
    func openSystemSettings() {
        
        guard
            let settingsUrl = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsUrl)
            else {
                
                return
        }
        
        UIApplication.shared.open(settingsUrl)
    }
}
