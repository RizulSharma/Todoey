//
//  Item.swift
//  To_Dos
//
//  Created by Rizul Sharma on 03/04/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title : String = ""
   @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
