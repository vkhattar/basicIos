//
//  PlacesViewController.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-12.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit
import Firebase

class PlacesViewController: UITableViewController {
    
    //MARK: Properties
    var placeStore:PlaceStore!
    
    //MARK: Firebase properties
    
    //refer to the location in Firebase
    let ref = Firebase(url: "https://floatout.firebaseio.com/")
    //stores current user's interestRef
    var placesRef: Firebase!
    
    //MARK: Overriding views

    override func viewDidLoad() {
        super.viewDidLoad()
        //These two lines are mandatory for making the rows dynamic in height,
        //atleast the first one. Second is for performance.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        //set The placesRef
        placesRef = ref.childByAppendingPath("places")

        //Updating the tableView with the places listed from Firebase
        placesRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            for item in snapshot.children{
                let place = Place(snapshot: item as! FDataSnapshot)
                self.placeStore.addPlace(place)
            }
            self.tableView.reloadData()
            }, withCancelBlock: {error in print(error.description)})
        
        //initialize place array.
        //addSamplePlaces()
    }

    //Returning the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //returning the number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeStore.allPlaces.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //getting the cell
        let cellIdentifier = "PlaceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlaceTableViewCell
        
        //Setting up the cell
        //set up the image
        let imageName = placeStore.allPlaces[indexPath.row].name
        let image = UIImage.init(named: imageName)
        let newImage = imageWithImage(image!, scaledToSize: CGSizeMake(460,283))
        cell.placePicture.image = newImage
        
        //adding color and borderwidth
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1.0
        
        return cell
    }
    
    //MARK: Methods
    func addSamplePlaces() {
        let place1 = Place(name: "PianoMan", location: "DeerPark",
                           genre: "Music", image: nil, addedByUser: false,
                           subGenre: ["Jazz", "Blues", "Live"])
          let place2 = Place(name: "HungryMonkey", location: "DeerPark",
                             genre: "Music", image: nil, addedByUser: false,
                             subGenre: ["Jazz", "Blues", "Desi","Live", "Open Mike"])
          let place3 = Place(name: "Depot29", location: "DeerPark",
                             genre: "Music", image: nil, addedByUser: false,
                             subGenre: ["Blues", "Desi", "Karoake", "Rock"])
        
        //Add to local store
        placeStore.allPlaces.append(place1)
        placeStore.allPlaces.append(place2)
        placeStore.allPlaces.append(place3)
        
        //Add to Firebase
        for place in placeStore.allPlaces {
            addPlaceToFire(place)
        }
     
    }
    
    //image resizing//http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
    //beautiful function
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func addPlaceToFire(place: Place){
        let placeObjectKeys = ["genre":place.genre, "subGenre":place.subGenre,
                               "location": place.location, "adedByUser": place.addedByUser!]
        let placeValue = place.name
        let placeObject = [placeValue: placeObjectKeys]
        placesRef.updateChildValues(placeObject)
    }
}