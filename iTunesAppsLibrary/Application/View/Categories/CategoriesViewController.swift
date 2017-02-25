//
//  CategoriesViewController.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

protocol CategoriesViewControllerCoordinator : class {
    
    
}

class CategoriesViewController: UIViewController {

    //MARK: - Properties
    weak var coordinator: CategoriesViewControllerCoordinator?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
