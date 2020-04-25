//
//  AppState.swift
//  blueface
//
//  Created by ukyo on 2020/04/22.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit

class AppState: NSObject {
    var facePreview: Bool!
    
    override init() {
        super.init()
        facePreview = true        
    }
}
