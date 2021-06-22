//
//  CreateOrderView.swift
//  Eldocode
//
//  Created by user on 21.06.2021.
//

import SwiftUI

struct CreateOrderView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productDB: ProductViewModel
    @Binding var showNext: Bool
    @Binding var selectedTab: Int
    @Binding var showSuccess: Bool
    @State var showAlert = false
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var qrId = ""
    @State var comment = ""
    @State var finishAdd = false
    var body: some View {
         if showSuccess{
            SuccessOrderView(showSuccess: $showSuccess, selectedTab: $selectedTab)
        } else {
        ZStack{
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
            VStack{
                HStack(spacing: 25){
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                    showNext.toggle()
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.init("red"))
                    .font(.system(size: 22, weight: .semibold))
            })
            
                    Text("Оформление заказа")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(20)
                VStack{
                    Text("Товары (\(productDB.productDB.reduce(0, {$0 + $1.count})) шт.)")
                    .font(.system(size: 21, weight: .semibold))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    VStack(spacing: 10){
                        ForEach(productDB.productDB, id:\.self){item in
                            ItemOrderCardView(productDBModel: item.self)
                    }
                        HStack(spacing:0){
                        Text("Итого ")
                            .foregroundColor(Color.black)
                            .font(.system(size: 17, weight: .semibold))
                            Text("\(productDB.productDB.reduce(0, {$0 + $1.price})) ₽")
                                .foregroundColor(Color.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.03))
                    .cornerRadius(10)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(20)
                VStack(alignment: .leading, spacing: 10){
                Text("Сотрудник")
                    .font(.system(size: 21, weight: .semibold))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    VStack(alignment: .leading, spacing: 0){
                        VStack(spacing: 6){
                        
                            Text("\(user.user.first?.firstName ?? "Имя") \(user.user.first?.middleName ?? "Фамилия") \(user.user.first?.lastName ?? "Отчество")")
                            .foregroundColor(Color.black)
                            .font(.system(size: 19, weight: .semibold))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(user.user.first?.email ?? "email@email.ru")")
                                .foregroundColor(Color.black)
                                .font(.system(size: 19, weight: .regular))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                       
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.03))
                    .cornerRadius(10)
                    
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.horizontal, 20)
                VStack(alignment: .leading, spacing: 10){
                Text("Клиент")
                    .font(.system(size: 21, weight: .semibold))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    VStack(alignment: .leading, spacing: 0){
                        if !finishAdd{
                            VStack(spacing: 6){
                                VStack{
                                    Spacer()
                                TextField("Ф.И.О.", text: $name)
                                    Spacer()
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.black.opacity(0.15))
                                }
                                .frame(height: 40)
                                    
                                VStack{
                                    Spacer()
                                TextField("Телефон", text: $phone)
                                    Spacer()
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.black.opacity(0.15))
                                }
                                .frame(height: 40)
                                VStack{
                                    Spacer()
                                TextField("Email", text: $email)
                                    Spacer()
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.black.opacity(0.15))
                                }
                                .frame(height: 40)
                                VStack{
                                    Spacer()
                                TextField("QR ID", text: $qrId)
                                    Spacer()
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.black.opacity(0.15))
                                }
                                .frame(height: 40)
                                VStack{
                                    Spacer()
                                TextField("Коментарий", text: $comment)
                                    Spacer()
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.black.opacity(0.15))
                                }
                                .frame(height: 40)
                                Button(action: {
                                    withAnimation(Animation.interactiveSpring()){
                                        finishAdd.toggle()
                                    }
                                }, label: {
                                    Text("Готово")
                                        .font(.system(size: 21, weight: .semibold))
                                        .foregroundColor(Color.init("red"))
                                })
                                .padding(.vertical, 5)
                            }
                        } else {
                        VStack(spacing: 6){
                            VStack{
                                Spacer()
                            Text("\(name)")
                            .foregroundColor(Color.black)
                            .font(.system(size: 19, weight: .semibold))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.black.opacity(0.15))
                            }
                            .frame(height: 40)
                            VStack{
                                Spacer()
                            Text("\(phone)")
                                .foregroundColor(Color.black)
                                .font(.system(size: 19, weight: .regular))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.black.opacity(0.15))
                            } .frame(height: 40)
                            VStack{
                                Spacer()
                            Text("\(email)")
                                .foregroundColor(Color.black)
                                .font(.system(size: 19, weight: .regular))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.black.opacity(0.15))
                            } .frame(height: 40)
                            VStack{
                                Spacer()
                            Text("\(qrId)")
                                .foregroundColor(Color.black)
                                .font(.system(size: 19, weight: .regular))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.black.opacity(0.15))
                            } .frame(height: 40)
                            if !comment.isEmpty{
                            VStack{
                                Spacer()
                            Text("\(comment)")
                                .foregroundColor(Color.black)
                                .font(.system(size: 19, weight: .regular))
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.black.opacity(0.15))
                            } .frame(height: 40)
                            }
                            Button(action: {
                                withAnimation(Animation.interactiveSpring()){
                                    finishAdd.toggle()
                                }
                            }, label: {
                                Text("Изменить")
                                    .font(.system(size: 21, weight: .semibold))
                                    .foregroundColor(Color.init("red"))
                            })
                            .padding(.vertical, 5)
                        }
                        }
                       
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.03))
                    .cornerRadius(10)
                    
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(20)
            }
            .padding(.bottom, 120)
        }
            VStack{
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Сформировать заказ")
                        .font(.system(size: 22,weight: .bold))
                        .foregroundColor(name.isEmpty || email.isEmpty || qrId.isEmpty || phone.isEmpty || !finishAdd ? Color.init(#colorLiteral(red: 0.269752562, green: 0.2697597742, blue: 0.2697558701, alpha: 1)) : Color.white)
                        .frame(maxWidth: .infinity,minHeight: 45)
                        .background(name.isEmpty || email.isEmpty || qrId.isEmpty || phone.isEmpty || !finishAdd ? Color.init(#colorLiteral(red: 0.7977497578, green: 0.7977686524, blue: 0.7977585196, alpha: 1)) : Color.init("red"))
                        .cornerRadius(5)
                        
                })
                .disabled(name.isEmpty || email.isEmpty || qrId.isEmpty || phone.isEmpty || !finishAdd)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Вы уверены?"), primaryButton: Alert.Button.default(Text("Отмена")), secondaryButton: Alert.Button.destructive(Text("Сформировать").foregroundColor(Color.black), action: {
                        withAnimation(Animation.interactiveSpring()){
                            showSuccess.toggle()
                        }
                    })
                )
            })
            }
        }
        }
    }
}


struct ItemOrderCardView: View{
    @EnvironmentObject var vm: ProductViewModel
    var productDBModel: ProductDBModel
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            HStack{
                ZStack{
                    Image(uiImage: vm.base64ToImage(productDBModel.photo ?? "")!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                .frame(width: 50, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(5)
                VStack(alignment: .leading,spacing: 5){
                    Text("\(productDBModel.firm.first?.name ?? "") \(productDBModel.name ?? "")")
                        .foregroundColor(Color.black)
                        .font(.system(size: 14, weight: .medium))
                        .lineLimit(1)
                    Text("\(productDBModel.count) шт.")
                        .foregroundColor(Color.black.opacity(0.6))
                        .font(.system(size: 12, weight: .medium))
                }
                .frame(maxWidth: .infinity,alignment: .leading)
          
                Text("\(productDBModel.price) ₽")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16, weight: .medium))
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.black.opacity(0.15))
                .padding(.top, 10)
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        
    }
}



