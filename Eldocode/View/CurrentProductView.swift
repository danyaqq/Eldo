//
//  CurrentProductView.swift
//  Eldocode
//
//  Created by Daniil on 20.06.2021.
//

import SwiftUI
import RealmSwift

struct CurrentProductView: View {
    var product: ProductModel
    let productDB = ProductDBModel()
    let categoryDB = CategoryDBModel()
    let firmDB = FirmDBModel()
    @Binding var selectedTab: Int
    @State var isAdded = false
    @Binding var showCurrentItem: Bool
    @EnvironmentObject var vm: ProductViewModel
    var body: some View {
        ZStack{
        VStack{
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                    self.showCurrentItem = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.init("red"))
                    .font(.system(size: 22, weight: .semibold))
            })
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(20)
            ZStack{
                Image(uiImage: product.photo)
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height / 4.5)
                .padding(20)
                .padding(.horizontal, 60)
            }
            .frame(height: UIScreen.main.bounds.height / 4.5)
            VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading, spacing: 16){
                Text("Арт. \(product.vendorCode)")
                    .font(.system(size: 17))
                    .foregroundColor(Color.black.opacity(0.7))
                HStack(spacing: 0){
                Text("\(product.firm.name) \(product.name)")
                    .font(.system(size: 17))
                    .foregroundColor(Color.black)
                }
                Text("\(product.price) ₽")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black.opacity(0.14))
                
            }
            }
            }

            VStack(alignment: .leading, spacing: 16){
                Text("Описание")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(product.description)
                    .font(.system(size: 17))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(20)
            .padding(.bottom, 60)
            
        }
        
        }
            VStack{
                Spacer()
                Button(action: {
                    if vm.checkIsAdd(model: product) == false{
                        productDB.id = product.id
                        productDB.name = product.name
                        productDB.price = product.price
                        firmDB.name = product.firm.name
                        firmDB.id = product.firm.id
                        categoryDB.id = product.category.id
                        categoryDB.name = product.category.name
                        productDB.firm.append(firmDB)
                        productDB.category.append(categoryDB)
                        productDB.descriptions = product.description
                        productDB.isAdded = true
                        productDB.count = 1
                        productDB.photo = vm.convertImageToBase64String(img: product.photo)
                    let realm = try! Realm()
                    try! realm.write{
                        vm.fetchData()
                        realm.add(productDB, update: .all)
                    }
                    } else {
                        withAnimation(Animation.interactiveSpring()){
                            selectedTab = 2
                        }
                    }
                    
                    
                }, label: {
                    Text(vm.checkIsAdd(model: product) == true ? "Товар в заказе" : "Добавить в заказ")
                        .font(.system(size: 22,weight: .bold))
                        .foregroundColor(vm.checkIsAdd(model: product) == true ? Color.black.opacity(0.7) : Color.white)
                        .frame(maxWidth: .infinity,minHeight: 45)
                        .background(vm.checkIsAdd(model: product) == true ? Color.black.opacity(0.09) : Color.init("red"))
                        .cornerRadius(5)
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .onAppear{


        }
    }
}

