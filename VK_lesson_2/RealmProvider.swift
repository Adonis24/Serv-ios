//
//  RealmProvider.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 24/02/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider{
    static func save<T:Object>(items: [T], config: Realm.Configuration = Realm.Configuration.defaultConfiguration, update: Bool = true){
       
      
        do{
            let realm = try Realm(configuration: config)
            
            try realm.write {
                realm.add(items, update: update)
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
    }
    static func get<T:Object>(_ type: T.Type, config: Realm.Configuration = Realm.Configuration.defaultConfiguration ) ->Results<T>?{
        do{
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            
            return realm.objects(type)
        }
        
     catch {
    print(error)
    }
    return nil
    
}
    static func savePhotoForUser(_ photos: [Photo],
                                 id: Int,
                                 config: Realm.Configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)) {
        do {
            let realm = try Realm(configuration: config)
            guard let user = realm.object(ofType: User.self, forPrimaryKey: id) else { return }
            try realm.write {
                user.photos.append(objectsIn: photos)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

