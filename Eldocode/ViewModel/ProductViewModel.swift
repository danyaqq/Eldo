//
//  ProductViewModel.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


class ProductViewModel: ObservableObject{
    @Published var product = [ProductModel]()
    @Published var categoryProduct = [ProductModel]()
    @Published var productDB:[ProductDBModel] = []
    @Published var isLoad = false
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return (img.pngData()?.base64EncodedString())!
    }
    
    func fetchData(){
        guard let dbRef = try? Realm() else { return }
        let result = dbRef.objects(ProductDBModel.self)
        self.productDB = result.compactMap({ (prod) -> ProductDBModel? in
            return prod
        })
    }
    
    func checkIsAdd(model: ProductModel) -> Bool{
        let realm = try! Realm()
        
        let dbb = realm.objects(ProductDBModel.self).first(where: { $0.id == model.id })
        
        if dbb?.id == model.id {
            return true
        } else {
            return false
        }
    }
    

    
    func getProducts(){
        let url = "http://eldocode.makievksy.ru.com/api/Product"
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                for i in json.arrayValue{
                    let id = i["Id"].intValue
                    let name = i["Name"].stringValue
                    let vendor = i["VendorCode"].stringValue
                    let categoryId = i["Category"]["Id"].intValue
                    let categoryName = i["Category"]["Name"].stringValue
                    let firmId = i["Firm"]["Id"].intValue
                    let firmName = i["Firm"]["Name"].stringValue
                    let price = i["Price"].intValue
                    let description = i["Description"].stringValue
                    let photo = i["Photo"].stringValue
                    self.product.append(ProductModel(id: id, name: name, firm: FirmModel(id: firmId, name: firmName), vendorCode: vendor, category: CategoryModel(id: categoryId, name: categoryName), price: price, description: description, isAdded: false, photo: self.base64ToImage(photo) ?? UIImage()))
                    
                }
                print(self.product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func getCategoryProducts(category: Int){

        let url = "http://eldocode.makievksy.ru.com/api/Product?categoryId=\(category)"
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                for i in json.arrayValue{
                    let id = i["Id"].intValue
                    let name = i["Name"].stringValue
                    let vendor = i["VendorCode"].stringValue
                    let categoryId = i["Category"]["Id"].intValue
                    let categoryName = i["Category"]["Name"].stringValue
                    let firmId = i["Firm"]["Id"].intValue
                    let firmName = i["Firm"]["Name"].stringValue
                    let price = i["Price"].intValue
                    let photo = i["Photo"].stringValue

                    let description = i["Description"].stringValue
                    self.categoryProduct.append(ProductModel(id: id, name: name, firm: FirmModel(id: firmId, name: firmName), vendorCode: vendor, category: CategoryModel(id: categoryId, name: categoryName), price: price, description: description, isAdded: false, photo: self.base64ToImage(photo) ?? UIImage()))
                    DispatchQueue.main.async {
                                    self.isLoad = true
                    }
                }
                print(self.categoryProduct)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
