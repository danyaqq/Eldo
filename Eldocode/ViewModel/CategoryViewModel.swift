//
//  CategoryViewModel.swift
//  Eldocode
//
//  Created by Daniil on 19.06.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoryViewModel: ObservableObject{
    @Published var category = [CategoryModel]()
    
    func getCategory(){
        let url = "http://eldocode.makievksy.ru.com/api/Category"
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                for i in json.arrayValue{
                    let name = i["Name"].stringValue
                    let id = i["Id"].intValue
                    self.category.append(CategoryModel(id: id, name: name))
                }
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
