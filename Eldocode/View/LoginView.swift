//
//  LoginView.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var category: CategoryViewModel
    @Binding var numberPage: Int
    @State var login = ""
    @State var password = ""
    @State var showAlert = false
    @State var alertText = ""
    var body: some View {
        ZStack{
            //Gradient Eldocode
//            LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.0674386248, green: 0.06195222586, blue: 0.1384334266, alpha: 1)), Color.init(#colorLiteral(red: 0.3364455104, green: 0.2880736589, blue: 0.7027118802, alpha: 1))]), startPoint: .topLeading, endPoint: .trailing)
//                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    VStack(alignment: .leading, spacing: 12){
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom)
                        Text("Авторизация")
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth:.infinity, alignment: .center)
                            .padding(.bottom, 40)
                        Text("Логин")
                            .font(.system(size: 22, weight: .bold))
                        ZStack{
                            if login.isEmpty{
                                Text("login")
                                    .foregroundColor(Color.black.opacity(0.6))
                                    .font(.system(size: 19, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                            TextField("", text: $login)
                                .padding(.leading)
                                .font(.system(size: 19, weight: .medium))
                                .frame(height: 40)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(login == "" ? Color.black.opacity(0.2) : Color.init("green")))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12){
                        Text("Пароль")
                            .font(.system(size: 22, weight: .bold))
                        ZStack{
                            if password.isEmpty{
                                Text("********")
                                    .font(.system(size: 19, weight: .medium))
                                    .foregroundColor(Color.black.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                            SecureField("", text: $password)
                                .padding(.leading)
                                .font(.system(size: 19, weight: .medium))
                                .frame(height: 40)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(password == "" ? Color.black.opacity(0.2) : Color.init("green")))
                        }
                    }
                    
                    Button(action: {
                        if login != "" && password != ""{
                            user.login(login: login, password: password){ login, error in
                                if login != "error"{
                                    print(login)
                                    withAnimation(Animation.interactiveSpring()){
                                        numberPage = 2
                                        UserDefaults.standard.setValue(true, forKey: "auth")
                                        UserDefaults.standard.setValue(self.login, forKey: "login")
                                        UserDefaults.standard.setValue(self.password, forKey: "password")
                                    }
                                } else {
                                    print(error)
                                    alertText = error.localizedLowercase
                                    showAlert.toggle()
                                }
                            }
                        } else {
                            alertText = "Заполните все поля"
                            showAlert.toggle()
                        }
                    }, label: {
                        Text("Войти")
                            .font(.system(size: 22,weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity,minHeight: 45)
                            .background(Color.init("red"))
                            .cornerRadius(5)
                        
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Ошибка"), message: Text(alertText), dismissButton: Alert.Button.default(Text("Ок")))
                    })
                    .padding(.top, 50)
                }
                .padding(.horizontal, 25)
                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 1.4)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.12), radius: 8)
            }
        }
        .environmentObject(user)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(numberPage: .constant(1))
    }
}
