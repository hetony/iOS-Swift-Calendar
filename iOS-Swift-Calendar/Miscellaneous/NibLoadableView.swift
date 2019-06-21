//
//  NibLoadableView.swift
//  iOS-Swift-Calendar
//
//  Created by Hsiao Ai LEE on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// MARK: - NibNameIdentifiable

public protocol NibNameIdentifiable {
    
    static var identifier: String { get }
}

extension NibNameIdentifiable where Self: UIView {
    
    static public var identifier: String {
        
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        
        return UINib(nibName: Self.identifier, bundle: Bundle(for: Self.self))
    }
}

// MARK: - NibLoadableView

public protocol NibLoadableView: class, NibNameIdentifiable {
    
    func prepareForStoryboardUsage()
}

extension NibLoadableView where Self: UIView {
    
    public static var nibInstance: Self {
        
        guard let loadedView = Self.nib.instantiate(withOwner: self, options: nil).first as? Self else {
            
            fatalError("XIB file with identifier: \(identifier) was not found or loaded!")
        }
        
        return loadedView
    }
    
    var nibViewInstance: UIView {
        
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            
            fatalError("XIB file with identifier: \(Self.identifier) was not found or loaded!")
        }
        
        return view
    }
    
    public func prepareForStoryboardUsage() {
        
        let view = nibViewInstance
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
}
