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
    
    let genre: String
    let sInterests: [String]
    let addedByUser: Bool
    let ref: Firebase?
    
    init(genre: String, sInterests: [String], addedByUser:Bool){
        self.genre = genre
        self.sInterests = sInterests
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.genre = snapshot.key
        self.sInterests = snapshot.value as! [String]
        self.addedByUser = true
        self.ref = snapshot.ref
    }

    
}
