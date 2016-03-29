//
//  Person.swift
//  Address
//
//  Created by 雪 禹 on 3/17/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class Person {
    // MARK: Properties
    
    var fname: String
    var lname: String
    var phone: String
    var email: String
    var date: String
    
    //MARK: Initialization
    
    init(fname: String, lname: String, phone: String, email: String, date: String){
        self.fname = fname
        self.lname = lname
        self.phone = phone
        self.email = email
        self.date = date
    }
    
    //MARK: toString
    func toString() ->String{
        let description = fname + "\t" + lname + "\t" + phone + "\t" + email + "\t" + date + "\n"
        return description
    }
    
    
}

