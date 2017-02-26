//
//  ApplicationListViewController.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit
import RxSwift

protocol ApplicationListViewControllerCoordinator : class {
    
    func applicationListViewController(applicationListViewController viewController: ApplicationListViewController, didSelectApplicationViewModel viewModel: ApplicationViewModel)
}

class ApplicationListViewController: UIViewController {

    //MARK: - Properties
    weak var coordinator: ApplicationListViewControllerCoordinator?
    fileprivate let viewModel: ApplicationListViewModel
    fileprivate var categories: [Category] = []
    fileprivate var applications: [Application] = []
    fileprivate let disposeBag = DisposeBag()
    
    init(viewModel: ApplicationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ApplicationListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
