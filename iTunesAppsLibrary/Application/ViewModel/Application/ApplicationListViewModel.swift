//
//  ApplicationListViewModel.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import RxSwift

class ApplicationListViewModel {
    
    //MARK: - Properties
    fileprivate let disposeBag = DisposeBag()
    fileprivate var categories: [Category] = []
    fileprivate var applications: [Application] = []
    fileprivate var currentCategory: Category?
    var title = Variable<String>("")
    var loading = Variable<Bool>(false)

    //MARK: - Initializers
    init() {
        retrieveCategories()
    }
    
    fileprivate func retrieveCategories() {
        loading.value = true
        ApplicationAPI.load()
            .catchError { (error) -> Observable<[Application]> in
                //show error
                return Observable.just([])
            }
            .flatMap { [weak self] (applications) -> Observable<[Category]> in
                self?.applications = applications
                self?.title.value = LocalizableString.all.localizedString
                return ApplicationAPI.retrieveCategories()
            }
            .subscribe(onNext: { [weak self] (categories) in
                self?.loading.value = false
                self?.categories = categories
                }, onError: { [weak self] (error) in
                self?.loading.value = false
                    //show error
            })
            .addDisposableTo(disposeBag)
    }
    
    //MARK: - Delegate
    func retrieveApplications(forCategoryAtIndex index: Int?) {
        var categoryId: String? = nil
        var title = LocalizableString.all.localizedString
        if let index = index, index < categories.count {
            let category = categories[index]
            categoryId = category.id
            title = category.name
        }
        loading.value = true
        ApplicationAPI.retrieveApplications(forCategory: categoryId)
            .subscribe(onNext: { [weak self] (applications) in
                self?.title.value = title
                self?.applications = applications
                self?.loading.value = false
                }, onError: { [weak self] (error) in
                    self?.loading.value = false
            })
            .addDisposableTo(disposeBag)
    }
    
    //MARK: - DataSource
    func numberOfItemsForSection(section: Int) -> Int {
        return applications.count
    }
    
    func applicationInformation(forIndexPath indexPath: IndexPath) -> (String, String?) {
        guard indexPath.row < applications.count else {
            return ("", "")
        }
        let application = applications[indexPath.row]
        return (application.name, application.image?.thumbnailURLString)
    }
    
    func categoryNameForCurrentCategory() -> String {
        return currentCategory?.name ?? ""
    }
    
    func categoryName(forIndexPath indexPath: IndexPath) -> String {
        let category = categories[indexPath.row]
        return category.name
    }
}
