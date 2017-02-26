//
//  ApplicationServer.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

struct ApplicationServer {
    
    static func retrieveData() -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            
            let request = Alamofire.request(Router.categories).validate().responseArray(keyPath: "feed.entry") { (response: DataResponse<[Application]>) in
                
                switch response.result {
                case .success(let applications):
                    do {
                        try ApplicationStorage.save(applications: applications)
                        observer.onNext(true)
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
