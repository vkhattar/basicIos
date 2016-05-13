//
//  placesStore.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-12.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit

class PlaceStore {
    var allPlaces = [Place] ()
    
    func addPlace(place: Place){
        allPlaces.append(place)
    }
}
