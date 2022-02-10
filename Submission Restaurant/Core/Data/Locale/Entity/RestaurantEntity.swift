//
//  RestaurantEntity.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation
import RealmSwift

class RestaurantEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var pictureId: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var favorite = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
