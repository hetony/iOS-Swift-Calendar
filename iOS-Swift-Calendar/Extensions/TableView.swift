//
//  TableView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/15.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    public func registerHeader<T: UITableViewHeaderFooterView>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        
        register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T? where T: NibLoadableView {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            
            return nil
        }
        
        return cell
    }
}
