//
//  CategoriesCoordinator.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

class CategoriesCoordinator : Coordinator {
    
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    //MARK: - Initializers
    init() {
        
        rootViewController = UINavigationController()
        coordinators = [:]
        
//        let viewModel = SearchViewModel()
        let categoriesViewController = CategoriesViewController()
        categoriesViewController.coordinator = self
        let navigationController = UINavigationController(rootViewController: categoriesViewController)
        
        rootViewController = navigationController
    }
    
    func start() {
        
        
    }
}

extension CategoriesCoordinator: CategoriesViewControllerCoordinator {
    
    
}
