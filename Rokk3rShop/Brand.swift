//
//  Brand.swift
//  Rokk3rShop
//
//  Created by Konstantin Efimenko on 3/15/16.
//  Copyright © 2016 Kostiantyn Iefymenko. All rights reserved.
//

import Foundation
import RealmSwift

func ==(left: Brand, right: Brand) -> Bool {
    
    if left.name != right.name {
        return false
    }
    
    return true
}

class Brand: Object, Hashable {
    
    dynamic var name = ""
    
    override var hashValue : Int {
        get {
            return self.name.hashValue
        }
    }
    
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
