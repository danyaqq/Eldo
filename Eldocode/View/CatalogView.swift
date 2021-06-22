//
//  CatalogView.swift
//  Eldocode
//
//  Created by Daniil on 18.06.2021.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var category: CategoryViewModel
    @EnvironmentObject var productDB: ProductViewModel
    @StateObject var products = ProductViewModel()
    @Binding var selectedTab: Int
    @State var search = ""
    @State var showCategoryItems = false
    @State var showScanner = false
    var body: some View {
        if showCategoryItems{
            CategoryItemsView(showCategoryItems: $showCategoryItems, selectedTab: $selectedTab)
        } else {
        VStack{
            Text("Каталог")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
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
                .padding(.horizontal, 20)
            if search.isEmpty{
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 0){
                    ForEach(category.category, id: \.self){ category in
                        CategoryCardView(showCategoryItems: $showCategoryItems, category: category)
                }
                }
                .padding(.top)
                .padding(.bottom)
            })
            } else {
                Spacer()
            }
        }
        .onAppear {
            if products.product.isEmpty{
            products.getProducts()
            }
        }
        }
        
    }
}

struct CategoryCardView: View{

    @Binding var showCategoryItems: Bool
    var category: CategoryModel
    var body: some View{
        Button(action: {
            UserDefaults.standard.setValue(category.id, forKey: "categoryId")
            UserDefaults.standard.setValue(category.name, forKey: "categoryName")
            withAnimation(Animation.interactiveSpring()){
                showCategoryItems.toggle()
               
            }
        }, label: {
            VStack(spacing: 0){
                Spacer(minLength: 0)
                HStack{
                    Text(category.name)
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                .padding(.vertical, 15)
                Spacer(minLength: 0)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black.opacity(0.2))
            }
            
            .padding(.horizontal, 20)
        })


    }
}


