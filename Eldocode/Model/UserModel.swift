//
//  UserModel.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import Foundation


struct UserModel: Hashable{
    var middleName: String
    var id: Int
    var lastName: String
    var login: String
    var role: RoleModel
    var email: String
    var phone: String
    var firstName: String
    var store: StoreModel
    
}

struct StoreModel: Hashable{
    var address: String
    var id: Int
    var region: RegionModel
    var country: CountryModel
}

struct CountryModel: Hashable{
    var id: Int
    var name: String
}

struct RegionModel: Hashable{
    var id: Int
    var name: String
}

struct RoleModel: Hashable{
    var name: String
    var id: Int
}
