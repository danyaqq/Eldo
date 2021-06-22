//
//  WorkersStatView.swift
//  Eldocode
//
//  Created by user on 22.06.2021.
//

import SwiftUI

struct WorkersStatView: View {
    @State var selectedCategory = 1
    @Binding var showStat: Bool
    @State var showSort = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
            VStack{
                HStack(spacing: 25){
            Button(action: {
                withAnimation(Animation.interactiveSpring()){
                    showStat.toggle()
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.init("red"))
                    .font(.system(size: 22, weight: .semibold))
            })
            
                    Text("Статистика\nконсультатнов")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(20)
                Button(action:{
                    showSort.toggle()
                }){
                HStack{
                    Text("\(selectedCategory == 1 ? "За текущий месяц" : selectedCategory == 2 ? "За два месяца" : selectedCategory == 3 ? "За пол года" : selectedCategory == 4 ? "За год" : "Сортировать")")
                    .font(.system(size: 18, weight: .semibold))
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                }
                .foregroundColor(Color.black)
                .sheet(isPresented: $showSort) {
                    SortWorkersView(selectedCategory: $selectedCategory, showSort: $showSort)
                        
                }
                VStack(spacing: 15){
                    ForEach(workers, id: \.self){item in
                    VStack{
                        HStack{
                            ZStack{
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(item.place == 1 ? Color.init(#colorLiteral(red: 1, green: 0.8881620169, blue: 0, alpha: 1)) : item.place == 2 ? Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : item.place == 3 ? Color.init(#colorLiteral(red: 0.924925983, green: 0.4752413034, blue: 0, alpha: 1)) : Color.white)
                                Text("\(item.place)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.black)
                            }
                            VStack(alignment:.leading){
                                Text(item.name)
                            .font(.system(size: 17, weight: .semibold))
                                Text("\(item.countOrder) \(item.countOrder == 0 ? "заказов" : item.countOrder == 1 ? "заказ" : item.countOrder >= 2 && item.countOrder <= 5 ? "заказа" : item.countOrder >= 5 ? "заказов" : "")")
                                    .font(.system(size: 17))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal,20)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
                
            }
            
        }
        
    }
}


struct SortWorkersView: View{
    @Binding var selectedCategory: Int
    @Binding var showSort: Bool
    var body: some View{
        VStack{
            Text("Сортировать")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            VStack(alignment: .leading, spacing: 16){
            Button (action:{
                selectedCategory = 1
                showSort.toggle()
            }, label: {
                HStack(spacing: 16){
             
                    ZStack{
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.white)
                            .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                        Circle()
                            .frame(width: 7, height: 7)
                            .foregroundColor(selectedCategory == 1 ? Color.init("red") : Color.white)
                    }
                    Text("За текущий месяц")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color.black)
                   
                }
            })
            Button (action:{
                selectedCategory = 2
                showSort.toggle()

            }, label: {
                HStack(spacing: 16){
             
                    ZStack{
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.white)
                            .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                        Circle()
                            .frame(width: 7, height: 7)
                            .foregroundColor(selectedCategory == 2 ? Color.init("red") : Color.white)
                    }
                    Text("За два месяца")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color.black)
                   
                }
            })
                Button (action:{
                    selectedCategory = 3
                    showSort.toggle()

                }, label: {
                    HStack(spacing: 16){
                 
                        ZStack{
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                                .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                            Circle()
                                .frame(width: 7, height: 7)
                                .foregroundColor(selectedCategory == 3 ? Color.init("red") : Color.white)
                        }
                        Text("За пол года")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.black)
                       
                    }
                })
                Button (action:{
                    selectedCategory = 4
                    showSort.toggle()

                }, label: {
                    HStack(spacing: 16){
                 
                        ZStack{
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                                .overlay(Circle().stroke(lineWidth: 1).foregroundColor(Color.black.opacity(0.3)))
                            Circle()
                                .frame(width: 7, height: 7)
                                .foregroundColor(selectedCategory == 4 ? Color.init("red") : Color.white)
                        }
                        Text("За год года")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.black)
                       
                    }
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .padding(.top, 10)
            Spacer()
        }
    }
}

struct WorkerModel: Hashable{
    var name: String
    var place: Int
    var countOrder: Int
}

var workers = [WorkerModel(name: "Макиевский Станислав Евгеньевич", place: 1, countOrder: 38), WorkerModel(name: "Дмитриев Денис Сергеевич", place: 2, countOrder: 34), WorkerModel(name: "Дмитриев Денис Сергеевич", place: 3, countOrder: 31), WorkerModel(name: "Фролова Мария Ивановна", place: 4, countOrder: 28), WorkerModel(name: "Климова Екатерина Андреевна", place: 5, countOrder: 22), WorkerModel(name: "Сергеев Артём Евгеньевич", place: 6, countOrder: 17), WorkerModel(name: "Иванов Иван Иванович", place: 7, countOrder: 4), WorkerModel(name: "Слуцкий Роман Сергеевич", place: 8, countOrder: 1)]

struct WorkersCardView: View{
    var body: some View{
        VStack{
            HStack{
                ZStack{
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.8881620169, blue: 0, alpha: 1)))
                    Text("1")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.black)
                }
                VStack(alignment:.leading){
               Text("Иванов Иван Иванович")
                .font(.system(size: 17, weight: .semibold))
                    Text("18 заказов")
                        .font(.system(size: 17))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.black.opacity(0.2))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

struct WorkersStatView_Previews: PreviewProvider {
    static var previews: some View {
        WorkersStatView(showStat: .constant(true))
    }
}
