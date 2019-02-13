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
    
   
    
    public func getUser(for id: String, completion: (([User]?, Error?) -> Void)? = nil)  {
        
        let path = "/method/users.get"
        let params: Parameters = [
            "access_token":Session.instance.token,
            "user_ids": id,
            "v":"5.85"
        ]
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let users = json["list"].arrayValue.map { User(json: $0) }
                completion?(users, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    public func getFoto(for id: String, completion: (([Photo]?, Error?) -> Void)? = nil)  {
        
        let path = "/method/photos.getById"
        let params: Parameters = [
            "access_token":Session.instance.token,
            "id":id,
            "v":"5.85"
        ]
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let photos = json["list"].arrayValue.map { Photo(json: $0) }
                completion?(photos, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    

    public func getGroup( completion: (([Group]?, Error?) -> Void)? = nil)  {
        
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token":Session.instance.token,
            "extended":"1",
            "count":"2",
            "v":"5.85"
        ]
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let groups = json["items"].arrayValue.map { Group(json: $0) }
                completion?(groups, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
