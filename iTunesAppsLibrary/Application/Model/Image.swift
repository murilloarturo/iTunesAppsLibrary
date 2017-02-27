//
//  Image.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/25/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

struct ImageTransform: TransformType {
    
    typealias JSON = [[String: AnyObject]]
    typealias Object = Image
    
    func transformFromJSON(_ value: Any?) -> Image? {
        guard let value = value as? [[String: AnyObject]], value.count != 0 else {
            return nil
        }
        let imageDictionary = value.last!
        let thumbnailDictionary = value.first!
        let image = Image()
        image.imageURLString = imageDictionary["label"] as? String
        image.thumbnailURLString = thumbnailDictionary["label"] as? String
        
        return image
    }
    
    func transformToJSON(_ value: Image?) -> Array<[String : AnyObject]>? {
        return nil
    }
}

class Image: Object {
    
    //MARK: - Properties
    dynamic var imageURLString: String?
    dynamic var thumbnailURLString: String?
}
