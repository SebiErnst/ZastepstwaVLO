//
//  SubstitutionsTableViewController.swift
//  ZastepstwaVLO
//
//  Created by Prowadzący on 23/11/16.
//  Copyright © 2016 KIS. All rights reserved.
//

import UIKit

class SubstitutionsTableViewController: UITableViewController {
    
    var substitutions: [String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        print(substitutions)
        tableView.reloadData()
    }

    @IBAction func refreshSubstitutions(_ sender: Any) {
        let url = URL(string: "http://borg.kis.agh.edu.pl/~sebi/zastepstwa.php?date=2016-11-24")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, err in
            if data != nil {
                self.substitutions = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                DispatchQueue.main.async {
                    self.updateView()
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return substitutions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let teacherDict = Array(substitutions.values)[section] as! [String:String]
        return teacherDict.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubstitutionCell", for: indexPath)
        let teacherDict = Array(substitutions.values)[indexPath.section] as! [String:String]
        let lesson = Array(teacherDict.keys)[indexPath.row]
        let message = Array(teacherDict.values)[indexPath.row]
        cell.textLabel?.text = "Lekcja \(lesson)"
        cell.detailTextLabel?.text = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(substitutions.keys)[section]
//        return "a"
//        return substitutions.keys[section]
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
