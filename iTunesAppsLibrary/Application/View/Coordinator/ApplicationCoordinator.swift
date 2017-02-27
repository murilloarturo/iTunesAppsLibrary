//
//  ApplicationCoordinator.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit
import TTZoomTransition

class ApplicationCoordinator: NSObject, Coordinator {
    
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    //MARK: - Initializers
    override init() {
        rootViewController = UINavigationController()
        coordinators = [:]
        
        let viewModel = ApplicationListViewModel()
        let applicationListViewController = ApplicationListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: applicationListViewController)
        navigationController.navigationBar.isTranslucent = false
        
        rootViewController = navigationController
        
        super.init()
        applicationListViewController.coordinator = self
    }
    
    func start() {
        
        
    }
}

extension ApplicationCoordinator: ApplicationListViewControllerCoordinator {
    
    func applicationListViewController(applicationListViewController viewController: ApplicationListViewController, didSelectApplicationViewModel viewModel: ApplicationViewModel) {
        
        let applicationViewController = ApplicationViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: applicationViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = self
        
        self.rootViewController.present(navigationController, animated: true, completion: nil)
    }
}

extension ApplicationCoordinator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let zoomTransition = TTZoomTranstition()
        return zoomTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let zoomTransition = TTZoomTranstition()
        zoomTransition?.isPresenting = false
        return zoomTransition
    }
}
