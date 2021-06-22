//
//  SuccessOrderView.swift
//  Eldocode
//
//  Created by Daniil on 22.06.2021.
//

import SwiftUI
import RealmSwift

struct SuccessOrderView: View {
    @Binding var showSuccess: Bool
    @StateObject var productVM = ProductViewModel()
    @Binding var selectedTab: Int
    @State var offset = -UIScreen.main.bounds.width
    @State var height: CGFloat = 50
    var body: some View {
        VStack{
            Text("Заказ оформлен")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            
            ZStack{
                Circle()
                    .frame(height: height)
                    .foregroundColor(Color.init("green"))
                Image(systemName: "checkmark")
                    .font(.system(size: 66, weight: .semibold))
                    .foregroundColor(Color.white)
            }
            
            .offset(x: offset)
            .padding(20)
            VStack(spacing: 30){
                
                Text("Теперь вы можете\nсформировать новый заказ,\nдобавьте товары из каталога")
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
            Spacer()
        }
        .onAppear{
            withAnimation(Animation.easeIn){
                self.offset = 0
                self.height = UIScreen.main.bounds.height / 5
            }
   
            let realm = try! Realm()
            try! realm.write{
                realm.deleteAll()
            }
        }
    }
}


