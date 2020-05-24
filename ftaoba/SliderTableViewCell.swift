//
//  SliderTableViewCell.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/24.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var listener: ((_ value: Float) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        slider.addTarget(self, action: #selector(handleChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handleChange(sender: UISlider) {
        listener?(sender.value)
    }

}
