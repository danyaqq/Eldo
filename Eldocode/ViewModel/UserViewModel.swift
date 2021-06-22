//
//  UserViewModel.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import SwiftUI
import Alamofire
import SwiftyJSON

class UserViewModel: ObservableObject{
    @Published var user = [UserModel]()
    
    func login(login: String, password: String, com:(( _ data: String, _ error: String) -> Void)? = nil){
        let url = "http://eldocode.makievksy.ru.com/api/Worker?login=\(login)&password=\(password)"
        let parameters = ["login": login, "password": password]
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                let middle = json["MiddleName"].stringValue
                let first = json["FirstName"].stringValue
                let last = json["LastName"].stringValue
                let id = json["Id"].intValue
                let countryName = json["Store"]["Country"]["Name"].stringValue
                let countryId = json["Store"]["Country"]["Id"].intValue
                let regionName = json["Store"]["Region"]["Name"].stringValue
                let regionId = json["Store"]["Region"]["Id"].intValue
                let address = json["Store"]["Address"].stringValue
                let idStore = json["Store"]["Id"].intValue
                let phone = json["Phone"].stringValue
                let login = json["Login"].stringValue
                let roleName = json["Role"]["Name"].stringValue
                let roleId = json["Role"]["Id"].intValue
                let email = json["Email"].stringValue
                
                self.user.append(UserModel(middleName: middle, id: id, lastName: last, login: login, role: RoleModel(name: roleName, id: roleId), email: email, phone: phone, firstName: first, store: StoreModel(address: address, id: idStore, region: RegionModel(id: regionId, name: regionName), country: CountryModel(id: countryId, name: countryName))))
                print(self.user)
                com!(login, login)
            case .failure(let error):
                
                com!("error", error.localizedDescription)
                print(com!)
            }
        }
    }
}
