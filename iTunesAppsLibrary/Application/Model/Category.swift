//
//  Category.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class Category: Object, Mappable {
    
    //MARK: - Properties
    dynamic var id: String!
    dynamic var name: String!
    let applications = LinkingObjects(fromType: Application.self, property: "category")


    override class func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
    
    required init?(map: Map) {
        guard let attributes = map.JSON["attributes"] as? [String: AnyObject],
            let _ = attributes["im:id"],
            let _ = attributes["label"] else {
                return nil
        }
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    //Mappable
    func mapping(map: Map) {
        id      <- map["attributes.im:id"]
        name    <- map["attributes.label"]
    }
}
