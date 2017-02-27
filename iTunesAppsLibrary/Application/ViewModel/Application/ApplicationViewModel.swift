//
//  ApplicationViewModel.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation

struct ApplicationViewModel {
    
    //MARK: - Properties
    fileprivate let application: Application
    
    init(application: Application) {
        self.application = application
    }
    
    //MARK: - Public Methods
    func applicationTitle() -> String {
        return application.name
    }
    
    func applicationImage() -> String? {
        return application.image?.imageURLString
    }
    
    func applicationLink() -> String? {
        return application.link
    }
    
    func applicationSummary() -> String? {
        return application.summary
    }
}
