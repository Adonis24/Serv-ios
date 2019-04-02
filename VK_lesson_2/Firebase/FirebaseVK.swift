//
//  FirebaseVK.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 3/6/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


class FirebaseVK {
    let ref: DatabaseReference?
    let uid: String
    let uidInt: Int
    
    init(uid: String, uidInt: Int) {
        self.ref = nil
        self.uid = uid
        self.uidInt = uidInt
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let uid = value["uid"] as? String,
            let uidInt = value["uidInt"] as? Int else { return nil }
        
        self.ref = snapshot.ref
        self.uid = uid
        self.uidInt = uidInt
        
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "uid": uid,
            "uidInt": uidInt
        ]
    }
    
    
    static func addLoginDatabase(_ user: User) {
        let dataRef = Database.database().reference()
        dataRef.child(String(Session.shared.userId)).child("\(user.id)").setValue(user.toAnyObject)
    }
    
    static func addGroup(user: String, groups: [Group]){
        let dataRef = Database.database().reference()
        dataRef.child(String(Session.shared.userId)).child(user).updateChildValues(["groups":groups.map{$0.toAnyObject}])
    }
    
    static func checkedGroups (group: Group) {
        let ref = Database.database().reference()
        ref.child("\(String(Session.shared.userId))/addGroup").updateChildValues([String(group.id): group.name])
    }
    
    static func searchStory (searchText: String) {
        let ref = Database.database().reference()
        ref.child("\(String(Session.shared.userId))/story").updateChildValues([String(format: "%0.f", Date().timeIntervalSinceReferenceDate): searchText])
    }
    
}

