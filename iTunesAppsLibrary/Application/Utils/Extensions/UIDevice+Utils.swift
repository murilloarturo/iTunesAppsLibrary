//
//  UIDevice+Utils.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/26/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static func isiPad() -> Bool {
        
        return current.userInterfaceIdiom == .pad
    }
}
