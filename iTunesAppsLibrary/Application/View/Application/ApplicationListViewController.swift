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

protocol ApplicationListViewControllerCoordinator : class {
    
    func applicationListViewController(applicationListViewController viewController: ApplicationListViewController, didSelectApplicationViewModel viewModel: ApplicationViewModel)
}

class ApplicationListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    weak var coordinator: ApplicationListViewControllerCoordinator?
    fileprivate let viewModel: ApplicationListViewModel
    fileprivate var categories: [Category] = []
    fileprivate var applications: [Application] = []
    fileprivate let disposeBag = DisposeBag()
    fileprivate var showCategories = true
    
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
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                    self?.collectionView.reloadData()
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
    
    fileprivate func setupUI() {
        collectionView.registerCell(cell: CategoryCollectionViewCell.self)
        collectionView.registerCell(cell: ApplicationCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UIDevice.isiPad() ? .horizontal : .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = layout
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
            return CGSize(width: self.view.frame.width/3, height: self.view.frame.height/2)
        } else {
            return CGSize(width: self.view.frame.width/2, height: self.view.frame.height/3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
