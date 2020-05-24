//
//  SwitchTableViewCell.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/24.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var onOff: UISwitch!
    var listener: ((_ isOn: Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        onOff.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handleSwitch(sender: UISwitch) {
        listener?(sender.isOn)
    }

}
