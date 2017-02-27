//
//  UIImageView+Networking.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/26/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
    
    func setImage(withURL url: URL, placeholderImage: UIImage?) {
        af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
