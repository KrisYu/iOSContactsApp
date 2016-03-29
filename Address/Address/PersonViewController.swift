//
//  ViewController.swift
//  Address
//
//  Created by 雪 禹 on 3/17/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController,UITextFieldDelegate {
    // MARK: Properties
    

    
    @IBOutlet weak var fnameField: UITextField!
    @IBOutlet weak var lnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
        This value is ethier passed by `PersonTableViewController` in `prepareForSegue(_:sender)`
        or constructed as part of adding a new meal.

    */
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        fnameField.delegate = self
        lnameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        dateField.delegate  = self
        
        //Set up views if editing an existing Person
        if let person = person{
            navigationItem.title = person.lname
            fnameField.text = person.fname
            lnameField.text = person.lname
            phoneField.text = person.phone
            emailField.text = person.email
            dateField.text  = person.date
        }
        
        fnameField.becomeFirstResponder()
        // Enable the Save button only if fname is blank
        checkValidPerson()
        
        // Set up the date input field
        setDateFieldToolBar()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == fnameField){
            lnameField.becomeFirstResponder()
        } else if (textField == lnameField){
            phoneField.becomeFirstResponder()
        } else if (textField == phoneField){
            emailField.becomeFirstResponder()
        } else if (textField == emailField) {
            dateField.becomeFirstResponder()
        } else if(textField == dateField){
            dateField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidPerson()
        navigationItem.title = lnameField.text
    }
    
    

    func checkValidPerson(){
        //Disable the save button if the lname,phone,email,date is empty
        let fname = fnameField.text ?? ""
        // only enable save & delete button if there's value
        saveButton.enabled = !fname.isEmpty
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
            
        if isPresentingInAddMealMode{
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }

    }
    
    
    // Configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let fname = fnameField.text!
            let lname = lnameField.text ?? ""
            let phone = phoneField.text ?? ""
            let email = emailField.text ?? ""
            let date  = dateField.text ?? ""
            
            person = Person(fname: fname,lname: lname,phone: phone,email: email,date: date)
            
            
        }
    }
    
    
    
    
    // MARK: Actions

    
    
    // actions and settings datefield
    
    @IBAction func dateFieldEditing(sender: UITextField) {
        
        setDateFieldToday()
        let datePickerView = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.maximumDate = NSDate()
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(PersonViewController.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    

    
    func datePickerValueChanged(sender: UIDatePicker){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateField.text = dateFormatter.stringFromDate(sender.date)

    }
    
    
    //set up toolbar for datefield
    func setDateFieldToolBar(){
        
        let toolBar = UIToolbar(frame: CGRectMake(0,self.view.frame.size.height/6,self.view.frame.size.width,40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(PersonViewController.donePressed(_:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        toolBar.setItems([flexSpace,okBarBtn], animated: true)
        dateField.inputAccessoryView = toolBar
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func donePressed(sender: UIBarButtonItem){
        dateField.resignFirstResponder()
    }
    
    func setDateFieldToday(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        print(dateFormatter.stringFromDate(NSDate()))
        dateField.text = dateFormatter.stringFromDate(NSDate())
    }
 

}

