//
//  ChatView.swift
//  Eldocode
//
//  Created by user on 22.06.2021.
//

import SwiftUI

struct ChatView: View {
    @State var showChatView = false
    @State var yourText = ""
    @State var name = ""
    var body: some View {
      
            
        
        VStack{
            Text("Чат")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 8){
                ForEach(previewMessage, id:\.self){message in
                    Button(action: {
                        withAnimation(Animation.interactiveSpring()){
                            showChatView.toggle()
                            name = message.username
                        }
                    }, label: {
                        MessageCardView(showChatView: $showChatView, message: message)
                    })
                    .fullScreenCover(isPresented: $showChatView, content: {
                        ChatsView(name: $name, showChatView: $showChatView)
                    })
                    
                }
                }
                .padding(.top)
                .padding(.bottom, 80)
            })
        }
        
    }
}

struct MessageCardView: View {
    @Binding var showChatView: Bool
    var message: MessageModel
    var body: some View{
       
            HStack(alignment: .top, spacing: 10){
                
    
                VStack(alignment: .leading, spacing: 5){
                    Text(message.username)
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(message.message)
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4){
                    Text(message.time)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    if message.newMessageCount > 0 {
                    Text("\(message.newMessageCount)")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3.5)
                        .background(Color.init("green").opacity(0.6).clipShape(Capsule()))
                    }
                    else{
                        Text("")
                            .font(.system(size: 13))
                            .fontWeight(.heavy)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3.5)
                            .background(Color.clear.clipShape(Capsule()))
                    }
                }
            }
            .padding(8)
            .padding(.vertical, 10)
            .background(message.username == "Самойлова Яна" ? Color.init("green").opacity(0.2) : Color.black.opacity(0.05))
            .frame(width: UIScreen.main.bounds.width - 16)
            .cornerRadius(8)
       


       
       
    }
}


struct MessageModel: Hashable{
    var username: String
    var message: String
    var time: String
    var newMessageCount: Int
}

var previewMessage = [MessageModel(username: "Макиевский Станислав", message: "Хорошо!", time: "14:44", newMessageCount: 0), MessageModel(username: "Самойлова Яна", message: "Ваш заказ", time: "14:11", newMessageCount: 0)]

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


struct ChatsView: View {
    @Binding var name: String
    @Binding var showChatView: Bool
    @State var yourText = ""
    @StateObject var msgs = MessageViewModel()
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    showChatView.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.init("red"))
                        .font(.system(size: 22, weight: .semibold))
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    
                    HStack(spacing: 10){
                     
                        VStack(alignment: .leading, spacing: 5){
                            Text(name)
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .lineLimit(1)
                          
                        }
                    }

                    
                })
                Spacer()
            }
            .frame(height: 30)
            .padding(.horizontal, 16)
            .padding(.top, 15)
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 20){
                    ForEach(0..<msgs.message.count, id: \.self){ msg in
                    
                        MessagesCardsView(msg: msgs.message[msg].text, time: "16:23", isYourMsg: msgs.message[msg].text == "#покупаю" ? true : false)
                            .frame(maxWidth: .infinity, alignment: msgs.message[msg].text == "#покупаю" ? .leading : .trailing)
                            
                     
                }
                
                }
                .padding(.vertical)
            })
            HStack{
               TextField("Сообщение", text: $yourText)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                        .foregroundColor(yourText == "" ? Color.gray : Color.init("red").opacity(0.6))
                })
                .disabled(yourText == "")
            }
            .padding(.horizontal, 28)
            .padding(.bottom)
        }
        .onAppear{
            msgs.getMessages()
        }
    }
}

struct MessagesCardsView: View {
    var msg: String
    var time: String
    var isYourMsg: Bool
    var body: some View{
        HStack(alignment: .bottom){
            Text(msg)
                .foregroundColor(Color.black)
                .font(.system(size: 18))
            Text(time)
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
        }
        
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(isYourMsg ? Color.init("green").opacity(0.25) : Color.black.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal)
        
    }
}


