//
//  Interests.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-10.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import Foundation
import Firebase

class Interest: NSObject {
    
    let key: String
    let name: String
    let addedByUser: Bool
    let ref: Firebase?
    
    init(key: String, name: String, addedByUser:Bool){
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! Bool
        self.ref = snapshot.ref
    }

    
}
