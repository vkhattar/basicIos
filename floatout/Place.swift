//
//  place.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-12.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import Foundation
import Firebase

class Place : NSObject {
    
    let name: String
    let location: String
    let genre: String
    let addedByUser: Bool?
    let image: UIImage?
    let subGenre: [String]
    
    init(name: String, location: String, genre: String, image: UIImage?, addedByUser: Bool?, subGenre: [String]){
        self.name = name
        self.location = location
        self.genre = genre
        self.image = image
        self.addedByUser = false
        self.subGenre = subGenre
    }
    
    init(snapshot: FDataSnapshot){
        self.name = snapshot.key
        self.location = snapshot.value["location"] as! String
        self.genre = snapshot.value["genre"] as! String
        self.image = snapshot.value["image"] as? UIImage
        self.addedByUser = false
        self.subGenre = snapshot.value["subGenre"] as! [String]
    }
}

