//
//  ApplicationListViewController.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import AZDropdownMenu

protocol ApplicationListViewControllerCoordinator : class {
    
    func applicationListViewController(applicationListViewController viewController: ApplicationListViewController, didSelectApplicationViewModel viewModel: ApplicationViewModel)
}

let defaultNavigationBarHeight: CGFloat = 65.0
let navigationBarPadding: CGFloat = 10.0

class ApplicationListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    weak var coordinator: ApplicationListViewControllerCoordinator?
    fileprivate let viewModel: ApplicationListViewModel
    fileprivate var categories: [Category] = []
    fileprivate var applications: [Application] = []
    fileprivate let disposeBag = DisposeBag()
    fileprivate var menu: AZDropdownMenu?
    
    init(viewModel: ApplicationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ApplicationListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    fileprivate func setup() {
        setupUI()
        setupViewModel()
    }
    
    fileprivate func setupViewModel() {
        viewModel.loading.asObservable()
            .do(onNext: { [weak self] (loading) in
                if (loading) {
                    self?.showCollectionView(show: false)
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                    self?.setupMenuCategories()
                    self?.collectionView.reloadData()
                    self?.showCollectionView(show: true)
                }
            })
            .subscribe()
            .addDisposableTo(disposeBag)
        
        viewModel.title.asObservable()
            .do(onNext: { [weak self] (title) in
                self?.title = title
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func showCollectionView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.collectionView.alpha = show ? 1.0 : 0.0
        }
    }
    
    fileprivate func setupUI() {
        collectionView.registerCell(cell: ApplicationCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UIDevice.isiPad() ? .horizontal : .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = layout
        
        let button = UIBarButtonItem(title: LocalizableString.categories.localizedString, style: .plain, target: self, action: #selector(showCategories))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc fileprivate func showCategories() {
        if (self.menu?.isDescendant(of: self.view) == true) {
            self.menu?.hideMenu()
        } else {
            self.menu?.showMenuFromView(self.view)
        }
    }
    
    fileprivate func setupMenuCategories() {
        guard self.menu == nil else {
            return
        }
        
        self.menu = AZDropdownMenu(titles: viewModel.allCategoriesName())
        self.menu?.itemAlignment = .center
        self.menu?.menuSeparatorStyle = .none
        self.menu?.shouldDismissMenuOnDrag = true
        self.menu?.itemFontColor = UIColor.blue
        self.menu?.itemSelectionColor = UIColor.clear
        self.menu?.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            self?.viewModel.retrieveApplications(forCategoryAtIndex: indexPath.row)
        }
    }

}

extension ApplicationListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsForSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApplicationCollectionViewCell.identifier, for: indexPath) as! ApplicationCollectionViewCell
        let (name, imageURLString) = viewModel.applicationInformation(forIndexPath: indexPath)
        cell.applicationImageView.image = nil
        cell.applicationTitleLabel.text = name
        if let urlString = imageURLString, let url = URL(string: urlString) {
            cell.applicationImageView.setImage(withURL: url, placeholderImage: nil)
        }
        return cell
    }
}

extension ApplicationListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.isiPad() {
            return CGSize(width: self.view.frame.width/5, height: (self.view.frame.height/3))
        } else {
            return CGSize(width: self.view.frame.width/2, height: self.view.frame.height/3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        guard let applicationViewModel = viewModel.applicationViewModel(forIndexPath: indexPath) else {
            return
        }
        
        coordinator?.applicationListViewController(applicationListViewController: self, didSelectApplicationViewModel: applicationViewModel)
    }
}


