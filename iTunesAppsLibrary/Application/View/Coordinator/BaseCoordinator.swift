//
//  BaseCoordinator.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    //MARK: - Properties
    fileprivate var window: UIWindow
    fileprivate var coordinators: CoordinatorsDictionary
    
    var rootViewController: UIViewController {
        let coordinator = coordinators.popFirst()!.1
        return coordinator.rootViewController
    }
    
    //MARK: - Initializers
    init(window: UIWindow) {
        
        self.window = window
        coordinators = [:]
    }
    
    //MARK: - Coordinator
    func start() {
        
        showHome()
    }
    
    //MARK: - Utils
    private func showHome() {
        
        let splashViewController = SplashViewController(viewModel: SplashViewModel())
        splashViewController.coordinator = self
        window.rootViewController = splashViewController
    }
}

extension BaseCoordinator: SplashViewControllerCoordinator {
    
    func splashViewControllerDidFinish(splashViewController viewController: SplashViewController) {
        
        let applicationCoordinator = ApplicationCoordinator()
        coordinators[applicationCoordinator.name] = applicationCoordinator
        window.rootViewController?.present(applicationCoordinator.rootViewController, animated: true)
        applicationCoordinator.start()
    }
}
