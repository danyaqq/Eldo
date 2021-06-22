//
//  OnboardingView.swift
//  Eldocode
//
//  Created by user on 18.06.2021.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentCard = 0
    @Binding var numberPage: Int
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(currentCard == 0 ? Color.init("red") : Color.black.opacity(0.2))
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(currentCard == 1 ? Color.init("red") : Color.black.opacity(0.2))
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(currentCard == 2 ? Color.init("red") : Color.black.opacity(0.2))
                }
                .padding()
                        OnboardView(numberPage: $numberPage, currentCard: $currentCard)
            }
        }
    }
}


struct OnboardView: View {
    @Binding var numberPage: Int
    @Binding var currentCard: Int
    @State var offset:CGFloat = -UIScreen.main.bounds.width
    @State var secondOffset: CGFloat = UIScreen.main.bounds.width
    @State var thirdOffset: CGFloat = -UIScreen.main.bounds.width
    var body: some View{
        VStack{
            Spacer(minLength: 20)
            Image(currentCard == 0 ? "0" : currentCard == 1  ? "1" : currentCard == 2 ? "logo" : "logo")
                
                .resizable()
                .frame(height: 320)
                
                .scaledToFit()
                .offset(x: currentCard == 0 ? offset : currentCard == 1 ? secondOffset : currentCard == 2 ? thirdOffset : offset)
               
                
            Spacer()
            VStack{
                VStack(alignment: .center, spacing: 18){
           Text("Соберите корзину для покупателя")
            .font(.system(size: 26, weight: .bold))
            .foregroundColor(Color.init("green"))
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
                    Text("Спросите про его предпочтения и будьте вежливы")
                 .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.4))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
            }
            .padding(.horizontal, 60)
            Spacer()
            Button(action: {
                withAnimation(Animation.spring()){
                    currentCard += 1
                }
                if currentCard == 1{
                    withAnimation(Animation.spring()){
                        secondOffset = 0
                    }
                }
                if currentCard == 2{
                    withAnimation(Animation.spring()){
                        thirdOffset = 0
                    }
                }
                if currentCard == 3{
                    withAnimation(Animation.spring()){
                        numberPage = 2
                    }
                }
            }, label: {
                Text(currentCard == 2 ? "Авторизироваться" : "Далее")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundColor(currentCard == 2 ? Color.white : Color.init("green"))
                    
                    .frame(width: UIScreen.main.bounds.width - 40, height: 45)
                    .background(currentCard == 2 ? Color.init("red") : Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(currentCard == 2 ? Color.init("red") : Color.black.opacity(0.2)))
            })
            .padding(.bottom, 20)
          
            }
            
           
        }
        .onAppear(perform: {
            withAnimation(Animation.spring()){
               
                offset = 0
            }
        })
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(numberPage: .constant(1))
    }
}
