//
//  FileOperation.swift
//  Address
//
//  Created by 雪 禹 on 3/17/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit


class FileOp{
    
    // MARK: PROPERTIES
    var people = [Person]()

    init(){
        self.loadPeople()
    }
    
    
    func loadPeople(){
        
        let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent("contacts.txt")
        
        do {
            let content = try String(contentsOfURL:fileDestinationUrl,encoding:NSUTF8StringEncoding)
            let records = content.componentsSeparatedByString("\n")
            for record in records{
                let lst = record.componentsSeparatedByString("\t")
                if lst.count == 5 {
                    let person = Person(fname: lst[0], lname: lst[1], phone: lst[2], email: lst[3], date: lst[4])
                    self.people += [person]
                } else {
                    // do nothing
                }
            }
        } catch _ {
            print("error")
        }
    }
    

    
    func savePeople(people: [Person]){
        let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent("contacts.txt")
 
        
        var text = ""
        for person in people {
            text += person.toString()
        }
        
        do{
            // writing to disk
            
            print(fileDestinationUrl)
            try text.writeToURL(fileDestinationUrl, atomically: true, encoding: NSUTF8StringEncoding)
            // saving was successful. any code posterior code goes here
            do {
                let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
                print(mytext)   // "some text\n"
            } catch let error as NSError {
                print("error loading from url \(fileDestinationUrl)")
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print("error writing to url \(fileDestinationUrl)")
            print(error.localizedDescription)
        }
        
    }
    

    
}
