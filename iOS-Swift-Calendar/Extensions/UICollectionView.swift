//
//  UICollectionView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/14.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }
    
    public func registerFooter<T: UICollectionReusableView>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
    }
    
    public func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    public func dequeueReusableFooter<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T? where T: NibLoadableView {
        
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T
    }
    
    public func dequeueReusableHeader<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T? where T: NibLoadableView {
        
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T
    }
    
    public func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? where T: NibLoadableView {

        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}
