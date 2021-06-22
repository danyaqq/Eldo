//
//  ProductDBModel.swift
//  Eldocode
//
//  Created by Daniil on 20.06.2021.
//

import Foundation
import RealmSwift

class ProductDBModel: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var isAdded: Bool = false
    @objc dynamic var photo: String?
    @objc dynamic var descriptions: String?
    var firm = List<FirmDBModel>()
    @objc dynamic var vendorCode: String?
    var category = List<CategoryDBModel>()
    @objc dynamic var price: Int = 0
    @objc dynamic var count: Int = 1
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(firm: FirmDBModel, category: CategoryDBModel) {
        self.init()
        self.firm.append(firm)
        self.category.append(category)
        
    }
}

class FirmDBModel: EmbeddedObject{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?


}

class CategoryDBModel: EmbeddedObject{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?


}
