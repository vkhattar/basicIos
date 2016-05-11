//
//  addInterestViewController.swift
//  floatout
//
//  Created by Vedant Khattar on 2016-05-10.
//  Copyright © 2016 Vedant Khattar. All rights reserved.
//

import UIKit

class addInterestViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mainInterest: UITextField!
    @IBOutlet weak var subInterest: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var interest : Interest?
    
    //MARK: Override Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the users input thru delegate callbacks
        mainInterest.delegate = self
        subInterest.delegate = self
        checkValidInterests()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidInterests()
        navigationItem.title = mainInterest.text
    }
    
    func checkValidInterests() {
        let mInterest = mainInterest.text ?? ""
        let sInterest = subInterest.text ?? ""
        saveButton.enabled = !mInterest.isEmpty && !sInterest.isEmpty
    }
    
    //Preparing the view controller before its presented
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Saving the interest
        if saveButton === sender {
            let genre = mainInterest.text!
            //lets create the subInterests array here from the subInterests textField
            let sInterestsArray = subInterest.text!.componentsSeparatedByString("##")
            let userFlag = true
            interest = Interest(genre: genre, sInterests:sInterestsArray, addedByUser: userFlag)
        }
    }
    


}
