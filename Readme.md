# Contacts App

This App is made as an homework.

![contacts ](https://github.com/KrisYu/iOSContactsApp/blob/master/add.gif)

[gif][]
It is made to accommodate the requirements of one homework. So it didn't use some regulations of iOS development, also this tutorial is a reminder for myself.

It is largely learned from Apple [Start Developing iOS Apps(Swift)][id]

[id]:https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/


### Person.swift

This class is used to store the contact.


### PersonViewController.swift

This is the controller to control person view. that is the page to add and edit contact.

Partically notice I used datePicker as an input textBox and set the maximum date to today.

Learned from :

[change-textfield-input-to-datepicker][id2]

[id2]: http://blog.apoorvmote.com/change-textfield-input-to-datepicker/

Also notice I changed the keypad style of different TextField, disable auto correct.

### PersonTableViewCell.swift

This is used to define a custom cell. 


### PersonTableViewController.swift


Several interesting function to notice:

- sort :
This will make the people list sorted by first name, this is similar to C++ reload function, this is very concise and beautiful.


```
	 // sort list 
	 func sortList() {
	     people.sortInPlace() { $0.fname < $1.fname } // sort the people by name
	     tableView.reloadData(); // notify the table view the data has changed
	 }
    
```

Learned from here : 
[How we can sort(ascending and descending) a uitableview data in swift language][id3]

[id3]:http://stackoverflow.com/questions/25960064/how-we-can-sortascending-and-descending-a-uitableview-data-in-swift-language


- swipe to delete but with confirmation :
just use swipe to delete is kind of too sloppily, while I don't know how to imitate  the real contacts app, seems a lot of delegate or sth.

Learned from here : [swipe to delete with confirmation][id4]

[id4]:https://www.andrewcbancroft.com/2015/07/16/uitableview-swipe-to-delete-workflow-in-swift/#confirm

And I do have a lot of unclear parts in this file. I didn't quite understand some code at this point, the segue is just imitate the Apple Document.


### FileOp.swift

This is very ugly code|||. Hope someday can improve it.


