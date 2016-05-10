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
    var USER_REF: Firebase!

    
    //MARK: Overriding views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //These two lines are mandatory for making the rows dynamic in height, 
        //atleast the first one. Second is for performance.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        //Adding the edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        //loading sample data
        createSampleInterests()
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
        cell.keyLabel.text = interest.key
        cell.nameLabel.text = interest.name
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
                interestStore.allInterests.append(interest)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
                //Adding to Firebase. Yes it is working.
                let intArray = [interest.key:[interest.name]]
                let interest_user_ref = USER_REF.childByAppendingPath("interests")
                interest_user_ref.updateChildValues(intArray)
                
            }
        }
    }
    
    //MARK: Internal Methods
    func createSampleInterests() {
        let interest1 = Interest(key: "Music", name: "Jazz", addedByUser: false)
        let interest2 = Interest(key: "Sports", name: "Soccer", addedByUser: false)
        interestStore.addInterest(interest1)
        interestStore.addInterest(interest2)
        
        //Adding to the server.
        //creating the user
        let usersRef = ref.childByAppendingPath("users")
        let user = ["full_name": "Vedant Khattar",
                      "date_of_birth" : "July 21, 1992",
                      "interests":[]]
        let users = ["vdon21" : user]
        usersRef.setValue(users)
        
        //Get users ref
        let userRef = usersRef.childByAppendingPath("vdon21")
        USER_REF = userRef
        //Creating interest
        let interest = ["interests": ["Music":["Jazz","Blues"]]]
        //updating child ref, this will not delete existing items, so be careful.
        userRef.updateChildValues(interest)
        
        
        
        
        
    }
    
}