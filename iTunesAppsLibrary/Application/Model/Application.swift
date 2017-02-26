//
//  Application.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class Application: Object, Mappable {
    
    //Mark: - Properties
    dynamic var id: String!
    dynamic var name: String!
    dynamic var image: Image?
    dynamic var summary: String?
    dynamic var price: Price?
    dynamic var title: String?
    dynamic var link: String?
    dynamic var category: Category?
    dynamic var releaseDate: String?
    
    override class func primaryKey() -> String? {
        return "id"
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
    required init?(map: Map) {
        guard let _ = map.JSON["id"] as? [String: AnyObject],
            let _ = map.JSON["im:name"] as? [String: AnyObject] else {
                return nil
        }
        super.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id.attributes.im:id"]
        name        <- map["im:name.label"]
        image       <- (map["im:image"], ImageTransform())
        summary     <- map["summary.label"]
        price       <- map["im:price"]
        title       <- map["title.label"]
        link        <- map["link.attributes.href"]
        category    <- map["category"]
        releaseDate <- map["im:releaseDate.attributes.label"]
    }
    
    func save() throws {
        let realm = try Realm()
        try realm.write {
            realm.add(self, update: true)
        }
    }
}
