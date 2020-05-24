//
//  SettingTableViewController.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/23.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

private let sectionTitles = ["View Setting", "Transforms", "Blend Shapes"]
private let counts = [1, transformIsOn.count, blendShapeIsOn.count]

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        blendShapeLabels
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counts[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SwitchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SwitchTableViewCell else {
            fatalError("not {cellIdentifier}")
        }

        switch indexPath.section {
        case 0:
            cell.label.text = "Camera Preview"
            cell.onOff.isOn = true
            break
        case 1:
            cell.label.text = transformLabels[indexPath.row]
            cell.onOff.isOn = transformIsOn[indexPath.row]
            cell.listener = { (b: Bool) -> Void in
                transformIsOn[indexPath.row] = b
            }
            break
        case 2:
            cell.label.text = blendShapeLabels[indexPath.row]
            cell.onOff.isOn = blendShapeIsOn[indexPath.row]
            cell.listener = { (b: Bool) -> Void in
                blendShapeIsOn[indexPath.row] = b
            }
            break
        default:
            fatalError("invalid index")
        }
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
