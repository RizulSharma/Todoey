//
//  Category.swift
//  To_Dos
//
//  Created by Rizul Sharma on 03/04/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
