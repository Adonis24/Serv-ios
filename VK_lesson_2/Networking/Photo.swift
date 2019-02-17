//
//  Photo.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import SwiftyJSON
class Photo: Codable, CustomStringConvertible   {
    
    var description: String {
        return "\(id) \(url)"
    }
    
    let id: Int
    let url: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["sizes"][1]["url"].stringValue
    }
    
}
