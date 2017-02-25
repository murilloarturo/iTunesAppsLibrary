//
//  Coordinator.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator: class {
    
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    
    var name: String {
        return String(describing: self)
    }
}
