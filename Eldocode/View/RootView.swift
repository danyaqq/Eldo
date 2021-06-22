//
//  RootView.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import SwiftUI

struct RootView: View {
    @StateObject var user = UserViewModel()
    @StateObject var category = CategoryViewModel()
    @EnvironmentObject var productDB: ProductViewModel
    @State var numberPage = UserDefaults.standard.bool(forKey: "auth") == true ? 2 : 1
    var body: some View {
        if numberPage == 1{
            LoginView(numberPage: $numberPage)
                .environmentObject(user)
                .environmentObject(category)
               
        } else if numberPage == 2{
            RootTabView(numberPage: $numberPage)
                .environmentObject(user)
                .environmentObject(category)
                
                .onAppear(perform: {
                    category.getCategory()
                    if UserDefaults.standard.bool(forKey: "auth") == true && user.user == []{
                        user.login(login: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!){
                            login, error in
                            if login != "error"{
                                print(login)
                            }
                            else {
                                numberPage = 1
                            }
                        }
                    }
                })
        } else if numberPage == 3{
            
        }
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
