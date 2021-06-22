//
//  CategoryItemsView.swift
//  Eldocode
//
//  Created by Daniil on 19.06.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct CategoryItemsView: View {
    @Binding var showCategoryItems: Bool
    @StateObject var productDB = ProductViewModel()
    @State var search = ""
    @Binding var selectedTab: Int
    @State var showCurrentItem = false
    @State var showScanner = false
    @State var showSort = false
    @State var selectedCategory = 0
    var body: some View {
        if showCurrentItem{
            CurrentProductView(product: productDB.categoryProduct.first(where: { $0.id == UserDefaults.standard.integer(forKey: "prodId") } )!, selectedTab: $selectedTab, showCurrentItem: $showCurrentItem).environmentObject(productDB)
        } else {
        VStack{
            Text(UserDefaults.standard.string(forKey: "categoryName") ?? "Категория")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            HStack(spacing: 20){
                Button(action: {
                    withAnimation(Animation.interactiveSpring()){
                        showCategoryItems.toggle()
                        UserDefaults.standard.removeObject(forKey: "categoryId")
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.init("red"))
                        .font(.system(size: 22, weight: .semibold))
                })
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.black.opacity(0.6))
                        .padding(.leading, 10)
                    ZStack{
                if search.isEmpty{
                    Text("Поиск товара")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,5)
                }
                TextField("", text: $search)
                    .padding(.leading,5)
                    .font(.system(size: 19, weight: .medium))
                    .frame(height: 40)
                    }
                    Button(action: {
                        showScanner.toggle()
                    }, label: {
                        Image(systemName: "barcode.viewfinder")
                            .foregroundColor(Color.black.opacity(0.6))
                            .font(.system(size: 22, weight: .semibold))
                    })
                  
                    .padding(.trailing, 10)
                }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(search == "" ? Color.black.opacity(0.2) : Color.init("green")))

            }
            .padding(.horizontal, 20)
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack{
                VStack{
                    HStack{
                        Button(action: {
                            showSort.toggle()
                            
                        }, label: {
                            HStack{
                                Text("Сортировать")
                                  
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.system(size: 16))
                            }
                        })
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundColor(Color.black)
                        .sheet(isPresented: $showSort) {
                            SortView(selectedCategory: $selectedCategory, showSort: $showSort).environmentObject(productDB)
                                
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.14))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                .padding(.top)
                    
                    if productDB.isLoad{
                    LazyVGrid(columns: [GridItem(.flexible(),spacing: 0),GridItem(.flexible(),spacing: 0)], alignment: .center, spacing: 25, content: {
                        
                        ForEach(productDB.categoryProduct){ item in
                            CatalogItemCardView(showCurrentItem: $showCurrentItem, selectedTab: $selectedTab, product: item).environmentObject(productDB)
                        }
                        
                        
                    })
                    .padding(.bottom, 30)
                    } else {
                        ProgressView()
                    }
                }
            })
        }
        .onAppear(perform: {
            
            if productDB.categoryProduct.isEmpty{
                productDB.getCategoryProducts(category: UserDefaults.standard.integer(forKey: "categoryId"))
            }
        })
        
        }
    }
}

struct CatalogItemCardView: View {
    @EnvironmentObject var productsDB: ProductViewModel
    @Binding var showCurrentItem: Bool
    @Binding var selectedTab: Int
    let productDB = ProductDBModel()
    let firmDB = FirmDBModel()
    let categoryDB = CategoryDBModel()
    var product: ProductModel
    var body: some View{
        VStack(spacing: 7){
            ZStack{
               
                Image(uiImage: product.photo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.width / 2 - 70)
                    .padding(10)
                    .onTapGesture {
                        withAnimation(Animation.interactiveSpring()){
                            self.showCurrentItem.toggle()
                            UserDefaults.standard.setValue(product.id, forKey: "prodId")
                        }
                      
                    }
                VStack{
                    Spacer()
                    Text("\(product.price) ₽")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.init("green"), radius: 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(8)
                
                
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 7)
            .overlay(VStack{
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.init("green"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .offset(x: -8, y: -8))
            VStack{
                Text(product.firm.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.9))
                    .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                Text(product.name)
                    .font(.system(size: 17))
                    .foregroundColor(Color.black.opacity(0.9))
                    .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onTapGesture {
                self.showCurrentItem.toggle()
                UserDefaults.standard.setValue(product.id, forKey: "prodId")
            }
            Button(action: {
                if productsDB.checkIsAdd(model: product) == true{
                    withAnimation(Animation.interactiveSpring()){
                        selectedTab = 2
                    }
                } else {
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
                productDB.photo = productsDB.convertImageToBase64String(img: product.photo)
                
                let realm = try! Realm()
              
                try! realm.write{
                    realm.add(productDB, update: .all)
                    
                }
                productsDB.fetchData()
                
                }
                
            }, label: {
                Text(productsDB.checkIsAdd(model: product) == true ? "В заказе" : "Добавить")
                    .font(.system(size: 16,weight: .bold))
                    .foregroundColor(productsDB.checkIsAdd(model: product) == true ? Color.black.opacity(0.7) : Color.white)
                    .frame(maxWidth: .infinity,minHeight: 30)
                    .background(productsDB.checkIsAdd(model: product) == true ? Color.black.opacity(0.09) : Color.init("red"))
                    .cornerRadius(5)
            })
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 50)

    }
}

struct SortView: View{
    @EnvironmentObject var productDB: ProductViewModel
    @Binding var selectedCategory: Int
    @Binding var showSort: Bool
    var body: some View{
       
            VStack{
                Text("Сортировать")
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                VStack(alignment: .leading, spacing: 16){
                Button (action:{
                    selectedCategory = 1
                    showSort.toggle()
//                    self.productDB.product = productDB.product.filter{ $0.price < $0.price}
                }, label: {
                    HStack(spacing: 16){
                 
                        ZStack{
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                                .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                            Circle()
                                .frame(width: 7, height: 7)
                                .foregroundColor(selectedCategory == 1 ? Color.init("red") : Color.white)
                        }
                        Text("Сначала дешевые")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.black)
                       
                    }
                })
                Button (action:{
                    selectedCategory = 2
                    showSort.toggle()
//                    self.productDB.product = productDB.product.filter{ $0.price > $0.price}
                }, label: {
                    HStack(spacing: 16){
                 
                        ZStack{
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                                .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                            Circle()
                                .frame(width: 7, height: 7)
                                .foregroundColor(selectedCategory == 2 ? Color.init("red") : Color.white)
                        }
                        Text("Сначала дорогие")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.black)
                       
                    }
                })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .padding(.top, 10)
                Spacer()
            }
        
    }
}



