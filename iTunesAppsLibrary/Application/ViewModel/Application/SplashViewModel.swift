//
//  SplashViewModel.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/27/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import RxSwift

class SplashViewModel {
    
    //MARK: - Properties
    fileprivate let disposeBag = DisposeBag()
    var loading = Variable<Bool>(false)
    
    init() {
        retrieveCategories()
    }
    
    fileprivate func retrieveCategories() {
        loading.value = true
        ApplicationAPI.load()
            .delay(1, scheduler: MainScheduler.instance)
            .catchError { (error) -> Observable<[Application]> in
                //show error
                return Observable.just([])
            }
            .subscribe(onNext: { [weak self] (categories) in
                self?.loading.value = false
                }, onError: { [weak self] (error) in
                    self?.loading.value = false
                    //show error
            })
            .addDisposableTo(disposeBag)
    }
}
