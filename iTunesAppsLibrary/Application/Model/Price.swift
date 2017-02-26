//
//  Price.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class Price: Object, Mappable {
    
    //MARK: - Properties
    dynamic var amount = 0.0
    dynamic var currency: String?
    
    required init?(map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    //Mappable
    func mapping(map: Map) {
        amount      <- map["attributes.amount"]
        currency    <- map["attributes.currency"]
    }
}
