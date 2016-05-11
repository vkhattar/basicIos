//
//  InterestsViewController.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-10.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit
import Firebase

class InterestsViewController: UITableViewController {
    
    //MARK: Properties
    
    //Giving access to the interestsStore
    var interestStore: InterestStore!
    
    //MARK: Firebase properties
    //refer to the location in Firebase
    let ref = Firebase(url: "https://floatout.firebaseio.com/")
    //stores current user ref
    var CurrentUserRef: Firebase!
    //stores current user's interest ref
    var currentUIR: Firebase!

    
    //MARK: Overriding views
    //viewDidLoad is called exactly once, when the view controller is firsst loaded into memory. This is where you want to instantiate any instance variables and build any views that live for the entire lifeCycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        //These two lines are mandatory for making the rows dynamic in height, 
        //atleast the first one. Second is for performance.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        //Adding the edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //Getting the reference to usersData.
        let usersRef = ref.childByAppendingPath("users")
        //Getting the current loggedInUser
        let currentUser = "vdon21"
        CurrentUserRef = usersRef.childByAppendingPath(currentUser)
        currentUIR = CurrentUserRef.childByAppendingPath("interests")
        
        //loading sample data
        createSampleInterests()
    }
    
    //This is called when the view is actually visitble and can be called multiple times during the lifecycle of a View Controller.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //Updating the tableView with the data from Firebase
        currentUIR.observeEventType(.Value, withBlock: { snapshot in
            for item in snapshot.children{
                print("hello \(item)")
                
            }
            }, withCancelBlock: {error in print(error.description)})
    }
    
    //Editing the tableView.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Delete the row from the data source
            interestStore.allInterests.removeAtIndex(indexPath.row)
            //deleting it from the tableView
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //MARK: Data source for table view
    
    //Returning the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //returning the number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestStore.allInterests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //getting the cell
        let cellIdentifier = "InterestTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InterestTableViewCell
        
        //Setting up the cell
        let interest = interestStore.allInterests[indexPath.row]
        cell.keyLabel.text = interest.genre
        var subInterests = " "
        for item in interest.sInterests {
            subInterests += ("#\(item)")
        }
        cell.nameLabel.text = subInterests
        
        //adding color and borderwidth
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1.0
    
        return cell
    }
    
    //MARK: IB METHODS
    
    //Exiting the controller on clicking on the save button(floatit)
    @IBAction func unwindToInterestList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? addInterestViewController, interest = sourceViewController.interest {
            //This will be used when editing existing interests
            if tableView.indexPathForSelectedRow != nil{
                print("existing")
            }
                //Adding New Interests
            else {
                let newIndexPath = NSIndexPath(forRow: interestStore.allInterests.count, inSection: 0)
                //adding the new interest to the store.
                interestStore.allInterests.append(interest)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
                //Adding to Firebase.
                let interestObject = [interest.genre : interest.sInterests]
                fbAddInterest(interestObject)
            }
        }
    }
    
    /*
     Should run only the first time the user is being created
     let user = ["full_name": "Vedant Khattar",
     "date_of_birth" : "July 21, 1992"]
     let users = ["vdon21" : user]
     usersRef.setValue(users)
     */
    
    //MARK: Internal Methods
    func createSampleInterests() {
       //Adding locally
        let interest1 = Interest(genre: "Music", sInterests: ["Jazz","Blues"], addedByUser: false)
        interestStore.addInterest(interest1)
        //Creating a sample interest
        let interestObject = ["Music":["Jazz","Blues"]]
        fbAddInterest(interestObject)
    }
    
    func fbAddInterest(interestObject : [String : Array<String>]){
        currentUIR.updateChildValues(interestObject)
    }
}