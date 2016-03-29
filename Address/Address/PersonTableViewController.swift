//
//  PersonTableViewController.swift
//  Address
//
//  Created by 雪 禹 on 3/17/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    let fileop = FileOp()
    var people = [Person]()
    var deletePeosonIndexPath: NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPeople()
        sortList()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PersonTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonTableViewCell

        let person = people[indexPath.row]
        
        cell.fnameLabel.text = person.fname
        cell.lnameLabel.text = person.lname
        cell.phoneLabel.text = person.phone
        

        return cell
    }

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deletePeosonIndexPath = indexPath
            let personToDelete = people[indexPath.row]
            confirmDelete(personToDelete)
//            people.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let personDetailViewControll = segue.destinationViewController as! PersonViewController
            
            // Get the cell that generated this segue
            if let selectedPersonCell = sender as? PersonTableViewCell{
                
                let indexPath = tableView.indexPathForCell(selectedPersonCell)!
                let selectedPerson = people[indexPath.row]
                personDetailViewControll.person = selectedPerson
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding new person.")
        }
    }

    
    @IBAction func unwindToPersonList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.sourceViewController as?
            PersonViewController, person = sourceViewController.person{
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    // Update an existing person.
                    people[selectedIndexPath.row] = person
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                } else {
                    //Add a new person.
                    let newIndexPath = NSIndexPath(forRow: people.count, inSection: 0)
                    people.append(person)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                }
            
        }
        savePeople()
        sortList()
    }
    
    // MARK: FileOperation
    
    func savePeople(){
        print(people.count)
        fileop.savePeople(people)
    }
    
    func loadPeople(){
        people = fileop.people
    }
    
    // sort list
    func sortList() {
        people.sortInPlace() { $0.fname < $1.fname } // sort the people by name
        tableView.reloadData(); // notify the table view the data has changed
    }
    
    // MARK: Delete with confirmation
    
    func confirmDelete(personToDelete: Person) {
        let alert = UIAlertController(title: "Delete Person", message: "Are you sure you want to permanently delete " + personToDelete.fname + " " + personToDelete.lname + " ?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeletePerson)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeletePerson)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func handleDeletePerson(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletePeosonIndexPath {
            tableView.beginUpdates()
            
            people.removeAtIndex(indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deletePeosonIndexPath = nil
            
            tableView.endUpdates()
            savePeople()
        }
    }
    
    func cancelDeletePerson(alertAction: UIAlertAction!) {
        deletePeosonIndexPath = nil
    }
    
}
