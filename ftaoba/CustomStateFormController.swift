//
//  CustomStateFormController.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/24.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

private let counts = [1, 2]

class CustomStateFormController: UITableViewController {

    // MARK: Properties
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var switchCell: UITableViewCell!
    @IBOutlet weak var sliderCell: UITableViewCell!
    
    var selectedCell: UITableViewCell?
    var customState: CustomState?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let cs = customState {
            labelField.text = cs.label
            switch cs.type {
            case .switch:
                selectedCell = switchCell
            case .slider:
                selectedCell = sliderCell
            }
        } else {
            labelField.text = ""
            selectedCell = switchCell
        }
        updateStateTypeView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return counts[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            selectedCell = tableView.cellForRow(at: indexPath)
            updateStateTypeView()
        }
        return indexPath
    }

    // MARK: - Navigation
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let value = customState?.value ?? 0
        customState = CustomState(label: labelField.text ?? "", type: selectedCell === switchCell ? .switch : .slider, value: value)
        
        
//        switch segue.identifier ?? "" {
//        case "NewItem":
//            customState = CustomState(label: "", type: .switch)
//        default:
//            fatalError("invalid identifier")
//        }
    }
    

    // MARK: Private methods
    private func updateStateTypeView() {
        switchCell.accessoryType = .none
        sliderCell.accessoryType = .none
        selectedCell?.accessoryType = .checkmark
    }
}
