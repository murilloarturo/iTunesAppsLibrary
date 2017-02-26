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
    let title = Variable<String>("")
    var loading = Variable<Bool>(false)

    //MARK: - Initializers
    init() {
        
        retrieveCategories()
    }
    
    func retrieveCategories() {
        ApplicationAPI.load()
            .catchError { (error) -> Observable<Bool> in
                //show error
                return Observable.just(true)
            }
            .flatMap { (result) -> Observable<[Category]> in
                return ApplicationAPI.retrieveCategories()
            }
            .subscribe(onNext: { [weak self] (categories) in
                self?.categories = categories
                }, onError: { [weak self] (error) in
                //show error
            })
            .addDisposableTo(disposeBag)
    }
}
