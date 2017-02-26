//
//  ApplicationAPI.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import RxSwift

enum APIError: Error {
    case unknown
    case parsing
    case database
}

struct ApplicationAPI {
    
    static func load() -> Observable<Bool> {
        return ApplicationServer.retrieveData()
    }
    
    static func retrieveCategories() -> Observable<[Category]> {
        return ApplicationStorage.retrieveCategories()
    }
    
    static func retrieveApplications(forCategory categoryId: String) -> Observable<[Application]> {
        return ApplicationStorage.retrieveApplications(forCategory: categoryId)
    }
}
