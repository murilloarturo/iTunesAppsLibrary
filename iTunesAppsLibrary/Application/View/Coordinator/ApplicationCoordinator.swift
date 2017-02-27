//
//  ApplicationCoordinator.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

class ApplicationCoordinator : Coordinator {
    
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    //MARK: - Initializers
    init() {
        
        rootViewController = UINavigationController()
        coordinators = [:]
        
        let viewModel = ApplicationListViewModel()
        let applicationListViewController = ApplicationListViewController(viewModel: viewModel)
        applicationListViewController.coordinator = self
        let navigationController = UINavigationController(rootViewController: applicationListViewController)
        navigationController.navigationBar.isTranslucent = false
        
        rootViewController = navigationController
    }
    
    func start() {
        
        
    }
}

extension ApplicationCoordinator: ApplicationListViewControllerCoordinator {
    
    func applicationListViewController(applicationListViewController viewController: ApplicationListViewController, didSelectApplicationViewModel viewModel: ApplicationViewModel) {
        
        
    }
}
