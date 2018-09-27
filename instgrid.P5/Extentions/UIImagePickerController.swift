//
//  UIImagePickerController.swift
//  instgrid.P5
//
//  Created by abdel on 27/09/2018.
//  Copyright © 2018 Najib ANNABi. All rights reserved.
//

import UIKit

// Put the PickerController in landscape mode

extension UIImagePickerController {
    open override var shouldAutorotate: Bool {
        return true
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
}
