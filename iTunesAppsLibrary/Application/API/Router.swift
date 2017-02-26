//
//  Router.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: AnyObject]

enum Router: URLRequestConvertible {
    
    //Search
    case categories
    
    static let serverPath = "https://itunes.apple.com/us/rss"
    
    var method: HTTPMethod {
        switch self {
        case .categories:
            return .get
        }
    }
    
    private var path : String {
        
        switch self {
        case .categories:
            return "/topfreeapplications/limit=20/json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: Router.serverPath)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return try Alamofire.JSONEncoding.default.encode(urlRequest)
    }
}
