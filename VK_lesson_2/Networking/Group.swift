//
//  Group.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import SwiftyJSON
class Group: Codable, CustomStringConvertible   {
    
    var description: String{
        return "Group: \(id) \(name)"
    }
        let id: Int
        let name: String
        let photo_50: String
    
    init(json:JSON) {
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo_50 = json["photo_50"].stringValue
        
        
    }
}
