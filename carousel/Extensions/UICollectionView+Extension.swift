//
//  UICollectionView+Extension.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        return className
    }
}
extension UICollectionView {
    
    func registerCustomCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil),
                 forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerCustomReusableHeaderView<T: UICollectionReusableView>(_ viewType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil),
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.identifier)
    }
    
    func registerCustomReusableView<T: UICollectionReusableView>(_ viewType: T.Type, kind: String) {
        register(UINib(nibName: T.identifier, bundle: nil),
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: T.identifier)
    }
    
    func registerCustomReusableFooterView<T: UICollectionReusableView>(_ viewType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil),
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCustomCell<T: UICollectionViewCell>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableCustomView<T: UICollectionReusableView>(with cellType: T.Type, indexPath: IndexPath, kind: String) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as! T
    }
    
    func dequeueReusableCustomHeaderView<T: UICollectionReusableView>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as! T
    }
    
    func dequeueReusableCustomFooterView<T: UICollectionReusableView>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as! T
    }
}
