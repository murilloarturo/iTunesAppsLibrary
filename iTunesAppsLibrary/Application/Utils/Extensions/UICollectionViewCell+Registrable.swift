//
//  UICollectionViewCell+Registrable.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/26/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier : String {
        
        return String(describing: self)
    }
    
    static var nib : UINib {
        
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    
    func registerCell(cell: UICollectionViewCell.Type) {
        
        register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }
}
