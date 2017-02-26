//
//  ApplicationStorage.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

struct ApplicationStorage {
    
    static func save(applications: [Application]) throws {
        for application in applications {
            try application.save()
        }
    }
    
    static func retrieveCategories() -> Observable<[Category]> {
        return Observable.create({ (observer) -> Disposable in
            let realm = try! Realm()
            observer.onNext(Array(realm.objects(Category.self)))
            observer.onCompleted()
            
            return Disposables.create {}
        })
    }
    
    static func retrieveApplications(forCategory categoryId: String) -> Observable<[Application]> {
        return Observable.create({ (observer) -> Disposable in
            let realm = try! Realm()
            observer.onNext(Array(realm.objects(Application.self).filter("category.id == %@", categoryId)))
            observer.onCompleted()
            
            return Disposables.create {}
        })
    }
}
