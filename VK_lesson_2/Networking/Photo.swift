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
        return "\(id) "
    }
    
    let id: Int
    let sizes: [String:JSON]
    let src: String
    let type: String
    let url: String
 
    
    init(json: JSON) {
        
        self.id = json["id"].intValue
        self.sizes = json["sizes"].dictionaryValue
        self.src = json["sizes"]["src"].stringValue
        self.type = json["sizes"]["type"].stringValue
        self.url = json["sizes"][8]["url"].stringValue
    }
    
}
