//
//  CatageoryEntity.swift
//  TheMealsApp
//
//  Created by Galfari on 07/01/22.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
 
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""
 
  override static func primaryKey() -> String? {
    return "id"
  }
}
