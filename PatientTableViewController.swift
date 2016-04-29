//
//  PatientTableViewController.swift
//  hospitalist
//
//  Created by Aana Bansal on 4/18/16.
//  Copyright © 2016 Aana Bansal. All rights reserved.
//

import UIKit

class PatientTableViewController: UITableViewController {

    // MARK: Properties
    
    var patients = [Patient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load the sample data.
        //loadSamplePatients()
        
        //read from database
        loadPatients()
    }

    func loadSamplePatients(){
        let patient1 = Patient(name: "Doug Stamper", index: 1)
        let patient2 = Patient(name: "Zoe Barnes", index: 4)
        let patient3 = Patient(name: "Frank Underwood", index: 3)
        
        patients.append(patient1!)
        patients.append(patient2!)
        patients.append(patient3!)
    }
    
    func loadPatients(){
        let URL = NSURL(string: "http://ec2-52-90-89-173.compute-1.amazonaws.com/queue")
        
        do {
            let htmlSource = try NSString(contentsOfURL: URL!, encoding: NSUTF8StringEncoding)
            let data = htmlSource.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            
            var foo = htmlSource.componentsSeparatedByString("\"")
            
            var name = foo[5]
            var index = Int(foo[21])
            let patient1 = Patient(name: name, index: index!)
            
            var name2 = foo[25]
            var index2 = Int(foo[41])
            let patient2 = Patient(name: name2, index: index2!)
            
            var name3 = foo[45]
            var index3 = Int(foo[61])
            let patient3 = Patient(name: name3, index: index3!)
            
            patients.append(patient1!)
            patients.append(patient2!)
            patients.append(patient3!)
            
            
            /*print(foo.count)
            print(foo[5])
            *var dataArray = split(htmlSource) {$0 == ":"}*/
            
           /* do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments ) as! [String: AnyObject]
                
                if let p = json["patientnames"] as? [String] {
                    print(p)
                }
            } catch {
                print("error: \(error)")
            }*/
        }
            
        catch let error as NSError{
            print ("ERROR: \(error)")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return patients.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PatientTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PatientTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let patient = patients[indexPath.row]
        
        cell.nameLabel.text = patient.name
        cell.indexLabel.text = String(patient.index)
        
        return cell
    }
}
