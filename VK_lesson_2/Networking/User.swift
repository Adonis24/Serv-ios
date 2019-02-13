//
//  User.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import SwiftyJSON

class User:CustomStringConvertible {
   var description: String {
        return "User \(first_name)"
    }
    let id: Int
    let first_name: String
    let last_name: String
    init(json: JSON) {
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
    }
}

