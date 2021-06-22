//
//  ProductModel.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import Foundation
import SwiftUI

struct ProductModel: Hashable, Identifiable{
    var id: Int
    var name: String
    var firm: FirmModel
    var vendorCode: String
    var category: CategoryModel
    var price: Int
    var description: String
    var isAdded: Bool
    var photo: UIImage
}

struct FirmModel: Hashable{
    var id: Int
    var name: String
}

struct CategoryModel: Hashable{
    var id: Int
    var name: String
}
