//
//  User.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Codable,CustomStringConvertible {
    var description: String {
        return "\(first_name) \(last_name)"
    }
    
    let id: Int
    let first_name: String
    let last_name: String
    let photo_50: String
    let photo_100: String
    let photo_200: String
    let photo_400_orig: String
    let deactivated: String
    
    init(json: JSON) {
        
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_50 = json["photo_50"].stringValue
        self.photo_100 = json["photo_100"].stringValue
        self.photo_200 = json["photo_200"].stringValue
        self.photo_400_orig = json["photo_400_orig"].stringValue
        self.deactivated = json["deactivated"].stringValue
        
    }
}


