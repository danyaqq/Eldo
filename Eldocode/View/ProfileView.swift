//
//  ProfileView.swift
//  Eldocode
//
//  Created by Daniil on 18.06.2021.
//

import SwiftUI
import RealmSwift
import SDWebImageSwiftUI

struct ProfileView: View {
    @Binding var numberPage: Int
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var category: CategoryViewModel
    @StateObject var productVM = ProductViewModel()
    @State var showStat: Bool = false
    var body: some View {
        if showStat{
            WorkersStatView(showStat: $showStat)
        } else {
            ScrollView(.vertical, showsIndicators: false, content: {
     
           
                
            
            Text("Профиль")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            Spacer()
            VStack(spacing: 25){
                Image("el")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                Text("\(user.user.first?.firstName ?? "user") \(user.user.first?.middleName ?? "") \(user.user.first?.lastName ?? "")")
                    .font(.system(size: 22, weight: .semibold))
            }
            Spacer()
            VStack(alignment: .leading, spacing: 0){
                VStack(alignment: .leading, spacing: 3){
                    Spacer(minLength: 0)
                    Text("Выполнение плана на месяц")
                        .font(.system(size: 18, weight: .semibold))
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color.black.opacity(0.1))
                            .frame(height: 15, alignment: .leading)
                        HStack(spacing: 0){
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color.init("red"))
                            .frame(width: UIScreen.main.bounds.width / 2, height: 15, alignment: .leading)
                            Spacer(minLength: 0)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("192,000 ₽ из 320,000 ₽")
                        .font(.system(size: 16))
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.2))
                    
                    
                }
               
                .frame(height: 80)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 6){
                    Spacer(minLength: 0)
                    Text("Адрес магазина")
                        .font(.system(size: 18, weight: .semibold))
                    Text(user.user.first?.store.address ?? "Россия")
                        .font(.system(size: 18))
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.2))
                }
                .frame(height: 70)
                VStack(alignment: .leading, spacing: 6){
                    Spacer(minLength: 0)
                    Text("Должность")
                        .font(.system(size: 18, weight: .semibold))
                    Text(user.user.first?.role.name ?? "Работник")
                        .font(.system(size: 18))
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.2))
                }
                .frame(height: 70)
                
                VStack(alignment: .leading, spacing: 6){
                    Spacer(minLength: 0)
                    HStack{
                    VStack{
                    Text("Успешных оформлений")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("4 шт.")
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "chevron.right")
         
                    }
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.2))
                }
                .frame(height: 70)
                .onTapGesture {
                    withAnimation(Animation.interactiveSpring()){
                        showStat.toggle()
                    }
                }
                    VStack(alignment: .leading, spacing: 6){
                        Spacer(minLength: 0)
                        Text("Рабочая почта")
                            .font(.system(size: 18, weight: .semibold))
                        Text(user.user.first?.email ?? "+7-999-999-99-99")
                            .font(.system(size: 18))
                        Spacer(minLength: 0)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.black.opacity(0.2))
                    }
                    .frame(height: 70)
               
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                    numberPage = 1
                    user.user.removeFirst()
                    category.category.removeAll()
                    if !productVM.productDB.isEmpty{
                    let realm = try! Realm()
                    try! realm.write{
                        realm.deleteAll()
                    }
                    }
                    UserDefaults.standard.setValue(false, forKey: "auth")
                }
            }, label: {
                Text("Выйти")
                    .font(.system(size: 22,weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity,minHeight: 45)
                    .background(Color.init("red"))
                    .cornerRadius(5)
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        
            })
        }
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(numberPage: .constant(2))
    }
}
