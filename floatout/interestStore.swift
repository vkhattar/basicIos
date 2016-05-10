//
//  interestStore.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-10.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit

class InterestStore {
    var allInterests = [Interest] ()
    
    func addInterest(interest: Interest){
        allInterests.append(interest)
    }
}
