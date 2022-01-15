//
//  CartView.swift
//  Eldocode
//
//  Created by Daniil on 18.06.2021.
//

import SwiftUI
import RealmSwift


struct CartView: View {
    
    @StateObject var productDB = ProductViewModel()
    @State var counter = 1
    @Binding var selectedTab: Int
    @State var showNext = false
    @State var showSuccess = false
    var body: some View {
        if showNext{
            CreateOrderView(showNext: $showNext, selectedTab: $selectedTab, showSuccess: $showSuccess).environmentObject(productDB)
        } else{
        VStack{
            Text("Заказ")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            if productDB.productDB.isEmpty{
            Spacer()
            EmptyCartView(selectedTab: $selectedTab)
            Spacer()
            } else {
                NotEmptyCartView(showNext: $showNext, counter: $counter).environmentObject(productDB)
            }
        }
        .onAppear {
            productDB.fetchData()
        }
        }
        
    }
}

struct EmptyCartView: View{

    @Binding var selectedTab: Int
    var body: some View{
        VStack(spacing: 30){
            Text("Заказ клиента пуст,\nдобавьте товары из каталога")
                .font(.system(size: 21))
                .multilineTextAlignment(.center)
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                    selectedTab = 1
                }
            }, label: {
                Text("Наполнить заказ")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(Color.init("red"))
            })
            
            
        }
        .padding(.horizontal, 20)
    }
}

struct NotEmptyCartView: View{
    @EnvironmentObject var productDB: ProductViewModel
    @Binding var showNext: Bool
    @Binding var counter: Int

    var body: some View{
        ZStack{
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 25){
               
                ForEach(productDB.productDB, id:\.self){ card in
                    if card.isInvalidated{
                    CartCardView(productDBModel: card.self, counter: $counter).environmentObject(productDB)
                    }
            }
                VStack(alignment: .leading, spacing: 16){
                    VStack(alignment: .leading, spacing: 2){
                        
                    Text("Итого")
                        .font(.system(size: 21, weight: .semibold))
                        Text("Товаров \(productDB.productDB.reduce(0, {$0 + $1.count})) шт.")
                            .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.5))
                    }
                    
                    Text("\(productDB.productDB.reduce(0, {$0 + $1.price})) ₽")
                        .font(.system(size: 23, weight: .bold))
                    
                }
                .padding(20)
                .padding(.bottom, 100)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
        })
            VStack{
                Spacer()
                Button(action: {
                    withAnimation(Animation.interactiveSpring()){
                        showNext.toggle()
                    }
                }, label: {
                    Text("Далее")
                        .font(.system(size: 22,weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity,minHeight: 45)
                        .background(Color.init("red"))
                        .cornerRadius(5)
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            productDB.fetchData()
        
        }
    }
}

struct CartCardView: View{
    var productDBModel: ProductDBModel
    
    @EnvironmentObject var productDB: ProductViewModel
    @State var showAlert = false
    @Binding var counter: Int
    var body: some View{
        HStack(alignment: .center, spacing: 20){
            ZStack{
                Image(uiImage: productDB.base64ToImage(productDBModel.photo ?? "")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.15), radius: 6)
            VStack(spacing: 25){
                HStack(alignment: .top){
                    Text("\(productDBModel.firm.first?.name ?? "") \(productDBModel.name ?? "")")
                    .lineLimit(2)
                    .font(.system(size: 15))
                    .foregroundColor(Color.black.opacity(0.9))
                    Spacer()
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        Image(systemName: "trash")
                            .font(.system(size: 17))
                            .foregroundColor(Color.init("red"))
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Удалить товар из корзины?"), primaryButton: Alert.Button.default(Text("Отмена")), secondaryButton: Alert.Button.destructive(Text("Удалить").foregroundColor(Color.black), action: {
                            let realm = try! Realm()
                            DispatchQueue.main.async {
                            try! realm.write{
                                realm.delete(productDBModel)
                                productDB.fetchData()
                                }
                                
                            }
                        })
                    )
                })
                }
                HStack{
                    HStack{
                        Button(action: {
                            let realm = try! Realm()
                            try! realm.write{
                            if productDBModel.count > 1{
                                productDBModel.price = productDBModel.price - productDBModel.price / productDBModel.count
                                productDBModel.count = productDBModel.count - 1
                                productDB.fetchData()
                                }
                            }
                        }, label: {
                            Image(systemName: "minus")
                                .font(.system(size: 15))
                                .foregroundColor(Color.init("green"))
                                .frame(width: 35, height: 30)
                                .background(Color.black.opacity(0.08))
                                .cornerRadius(8)
                        })
                        Text("\(productDBModel.count) шт.")
                            .font(.system(size: 15, weight: .semibold))
                        Button(action: {
                            let realm = try! Realm()
                            try! realm.write{
                            if productDBModel.count > 0{
                                productDB.fetchData()
                                productDBModel.price = productDBModel.price + productDBModel.price / productDBModel.count
                                productDBModel.count = productDBModel.count + 1
                                
                                }

                            }
                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 15))
                                .foregroundColor(Color.init("green"))
                                .frame(width: 35, height: 30)
                                .background(Color.black.opacity(0.08))
                                .cornerRadius(8)
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(productDBModel.price) ₽")
                        .font(.system(size: 15, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
        .onAppear{
            
            productDB.fetchData()
            
        }
    }
}

