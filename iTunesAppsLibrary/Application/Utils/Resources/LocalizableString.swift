//
//  LocalizableString.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/26/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation

enum LocalizableString : String {
    
    //MARK: - General
    case error = "Error"
    case ok = "Ok"
    
    //MARK: - Applications
    case all = "All"
    case categories = "Categories"
    
    case close = "Close"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    func localizedStringWithArguments(arguments: [CVarArg]) -> String {
        return String(format: self.localizedString, arguments: arguments)
    }
}
