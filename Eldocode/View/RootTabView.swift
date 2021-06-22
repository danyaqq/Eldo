//
//  RootTabView.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var category: CategoryViewModel
    @EnvironmentObject var productDB: ProductViewModel
    @Binding var numberPage: Int
    @State var selectedTab = 1
    var body: some View {
        VStack(spacing: 0){
        if selectedTab == 1{
          CatalogView(selectedTab: $selectedTab)
            .environmentObject(category)
        } else if selectedTab == 2{
            CartView(selectedTab: $selectedTab)
                
        } else if selectedTab == 3{
            ProfileView(numberPage: $numberPage)
                .environmentObject(user)
        } else if selectedTab == 4{
            ChatView()
        }
          
            CustomTabView(selectedTab: $selectedTab)
        }
        
    }
}

struct CustomTabView: View{
    @StateObject var productDB = ProductViewModel()
    @Binding var selectedTab: Int
    var body: some View{
        HStack{
            
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                selectedTab = 1
                }
            }, label: {
                VStack(spacing: 5){
                    Image(systemName: "text.magnifyingglass")
                        .font(.system(size: 24, weight: .medium))
                Text("Каталог")
                    .font(.system(size: 14, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            })
            .foregroundColor(selectedTab == 1 ? Color.init("green") : Color.black.opacity(0.5))
            
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                selectedTab = 2
                }
            }, label: {
                VStack(spacing: 5){
                    Image(systemName: "cart")
                        .font(.system(size: 24, weight: .medium))

                Text("Заказ")
                    .font(.system(size: 14, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            })
            .foregroundColor(selectedTab == 2 ? Color.init("green") : Color.black.opacity(0.5))
           
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                selectedTab = 4
                }
            }, label: {
                VStack(spacing: 5){
                    Image(systemName: "message")
                        .font(.system(size: 24, weight: .medium))
                Text("Чат")
                    .font(.system(size: 14, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            })
            .foregroundColor(selectedTab == 4 ? Color.init("green") : Color.black.opacity(0.5))
            
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                selectedTab = 3
                }
            }, label: {
                VStack(spacing: 5){
                    Image(systemName: "person")
                        .font(.system(size: 24, weight: .medium))
                Text("Профиль")
                    .font(.system(size: 14, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            })
            .foregroundColor(selectedTab == 3 ? Color.init("green") : Color.black.opacity(0.5))
          
        }
        .padding(.vertical, 6)
        .background(Color.white.edgesIgnoringSafeArea(.bottom))
        .shadow(color: Color.black.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear{
            productDB.fetchData()
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(numberPage: .constant(3)).environmentObject(CategoryViewModel())
            .environmentObject(UserViewModel())
    }
}
