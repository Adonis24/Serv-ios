//
//  VKServices.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class VKService {
    
    let baseUrl = "https://api.vk.com"
    
    static let sharedManager: SessionManager = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = 40
        
        let manager = Alamofire.SessionManager(configuration: config)
        return manager
    }()
    
   
    
    public func getUser(for city: String, completion: (([User]?, Error?) -> Void)? = nil)  {
        let path = "/data/2.5/forecast"
        
        let params: Parameters = [
            "q" : city,
            "units": "metric",
            "appId": "8b32f5f2dc7dbd5254ac73d984baf306"
        ]
        
        WeatherService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let weathers = json["list"].arrayValue.map { Weather(json: $0) }
                completion?(weathers, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
