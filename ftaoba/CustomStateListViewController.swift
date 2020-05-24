//
//  CustomStateListViewController.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/24.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

class CustomStateListViewController: UITableViewController {
    
    // MARK: Properties
    var editingIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customStates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var state = customStates[indexPath.row]
        switch state.type {
        case .switch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as? SwitchTableViewCell else {
                fatalError("not switch")
            }
            cell.label.text = state.label
            cell.onOff.isOn = state.value >= 0.5
            cell.listener = { (b: Bool) -> Void in
                state.value = b ? 1 : 0
                customStates[indexPath.row] = state
            }
            return cell
        case .slider:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as? SliderTableViewCell else {
                fatalError("not slider")
            }
            cell.label.text = state.label
            cell.slider.value = state.value
            cell.listener = { (value: Float) -> Void in
                state.value = value
                customStates[indexPath.row] = state
            }
            return cell
        }
    }
    
    

    // MARK: Actions
    @IBAction func unwindToCustomActionList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CustomStateFormController, let customState = sourceViewController.customState {
            if let indexPath = editingIndexPath {
                customStates[indexPath.row] = customState
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: customStates.count, section: 0)
                customStates.append(customState)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier ?? "" {
        case "NewItem":
            editingIndexPath = nil
            return
        case "EditItem":
            guard let customStateFormController = segue.destination as? CustomStateFormController else {
                fatalError("Unexpected destination")
            }
            
            guard let cell = sender as? UITableViewCell else {
                fatalError("Unexpected sender")
            }
            
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            editingIndexPath = indexPath
            customStateFormController.customState = customStates[indexPath.row]
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    

}
