//
//  CustomState.swift
//  ftaoba
//
//  Created by ukyo on 2020/05/24.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

enum CustomStateType: String {
    case `switch` = "switch"
    case slider = "slider"
}

struct CustomState {
    var label: String;
    var type: CustomStateType;
    var value: Float;
    
    init(label: String, type: CustomStateType, value: Float = 0) {
        self.label = label
        self.type = type
        self.value = value
    }
}
