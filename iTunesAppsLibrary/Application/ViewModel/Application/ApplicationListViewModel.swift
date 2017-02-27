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
                self?.categories = categories
                self?.loading.value = false
                }, onError: { [weak self] (error) in
                self?.loading.value = false
                    //show error
            })
            .addDisposableTo(disposeBag)
    }
    
    //MARK: - Delegate
    func retrieveApplications(forCategoryAtIndex index: Int) {
        loading.value = true
        var categoryId: String? = nil
        var title = LocalizableString.all.localizedString
        if index != 0, index < categories.count + 1 {
            let category = categories[index-1]
            categoryId = category.id
            title = category.name
        }
        ApplicationAPI.retrieveApplications(forCategory: categoryId)
            .delay(0.5, scheduler: MainScheduler.instance)
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
    
    func allCategoriesName() -> [String] {
        var names: [String] = []
        names.append(LocalizableString.all.localizedString)
        for category in self.categories {
            names.append(category.name)
        }
        return names
    }
    
    func categoryName(forIndexPath indexPath: IndexPath) -> String {
        let category = categories[indexPath.row]
        return category.name
    }
}
