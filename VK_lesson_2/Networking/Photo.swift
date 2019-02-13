//
//  Photo.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import SwiftyJSON
class Photo: CustomStringConvertible   {
    
    var description: String{
        return "Photo: \(id) \(text)"
        
    }
    
    let id: Int
    let album_id: Int
    let user_id: Int
    let owner_id: Int
    let text: String
    let photo_75: String
    let photo_130: String
    
    init(json: JSON){
        
        self.id = json["id"].intValue
        self.album_id = json["album_id"].intValue
        self.user_id = json ["user_id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.text    = json["text"].stringValue
        self.photo_75 = json["photo_75"].stringValue
        self.photo_130 = json["photo_130"].stringValue
        
    }
    
}
