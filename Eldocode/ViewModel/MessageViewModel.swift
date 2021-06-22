//
//  MessageViewModel.swift
//  Eldocode
//
//  Created by user on 22.06.2021.
//

import Foundation
import SwiftyJSON
import Alamofire


class MessageViewModel: ObservableObject{
    
    @Published var message = [MessageText]()
    
    func getMessages(){
        let url = "http://eldocode.makievksy.ru.com/api/Message?chatId=1&secretKey=MzAxLjAxLjAwMDEgMDowMDowMA=="
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                for i in json.arrayValue{
                    let text = i["Text"].stringValue
                    self.message.append(MessageText(text: text))
                    print(self.message)
                }
                print(json)
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
    }
    
}

struct MessageText: Hashable{
    var text: String
}
