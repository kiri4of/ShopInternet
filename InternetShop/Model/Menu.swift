//
//  Menu.swift
//  InternetShop
//
//  Created by Kiri4of on 07.07.2022.
//

import Foundation
import Firebase


struct Menu {
    var name: String //опциональный тип когда с интеренета идет подкачка файлов
    var imageURL: String
    var userId: String?
    var count: Int?
    var ref: DatabaseReference?
    
    init(name: String, imageURL: String, userId: String? = nil, count: Int? = 0) {
        self.name = name
        self.imageURL = imageURL
        self.userId = userId
        self.count = count
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]//Тк это JSON

         name = snapshotValue["name"] as! String
         imageURL = snapshotValue["imageURL"] as! String
         count = snapshotValue["count"] as? Int
         ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["name": name, "imageURL": imageURL, "userId": userId, "count": count]
    }
}

