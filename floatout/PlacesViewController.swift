//
//  PlacesViewController.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-12.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
    
    //MARK: Overriding views

    override func viewDidLoad() {
        super.viewDidLoad()
        //These two lines are mandatory for making the rows dynamic in height,
        //atleast the first one. Second is for performance.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    //Returning the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //returning the number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //getting the cell
        let cellIdentifier = "PlaceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlaceTableViewCell
        
        //Setting up the cell
        //labels should be already set
        //set up the image
//        cell.imageView?.image = UIImage.init(named: "PianoMan")
        
        //adding color and borderwidth
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1.0
        
        return cell
    }
    
    
}
