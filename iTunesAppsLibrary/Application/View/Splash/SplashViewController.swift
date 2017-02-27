//
//  SplashViewController.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/27/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit
import RxSwift

protocol SplashViewControllerCoordinator : class {
    
    func splashViewControllerDidFinish(splashViewController viewController: SplashViewController)
}

class SplashViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTransitionVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    weak var coordinator: SplashViewControllerCoordinator?
    fileprivate var disposeBag = DisposeBag()
    fileprivate let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup()
    }
    
    //MARK: - Setup
    fileprivate func setup() {
        
        titleVerticalConstraint.isActive = false
        titleTransitionVerticalConstraint.isActive = true
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: { 
                self.loadingLabel.alpha = 1.0
                self.activityIndicator.alpha = 1.0
                self.setupViewModel()
            })
        }
    }
    
    fileprivate func setupViewModel() {
        
        viewModel.loading.asObservable()
        .do(onNext: { [weak self] (loading) in
            if !loading {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.coordinator?.splashViewControllerDidFinish(splashViewController: strongSelf)
            }
        })
        .subscribe()
        .addDisposableTo(disposeBag)
    }
}
