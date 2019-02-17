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
    
   
    
    public func getFriends(completion: (([User]?, Error?) -> Void)? = nil)  {
        let extFields = "first_name,last_name,photo_50,photo_100,photo_200,photo_400_orig,deactivated"
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token":Session.instance.token,
            "fields": extFields,
            "order":"name",
            "v":"5.85"
        ]
        
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let users = json["response"]["items"].arrayValue.map { User(json: $0) }
                completion?(users, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    public func getFoto(completion: (([Photo]?, Error?) -> Void)? = nil)  {
        
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token":Session.instance.token,
            "v":"5.85"
        ]
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }
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
            "v":"5.85"
        ]
        
        VKService.sharedManager.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                completion?(groups, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
