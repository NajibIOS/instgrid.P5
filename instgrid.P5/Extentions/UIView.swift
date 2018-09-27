//
//  UIView.swift
//  instgrid.P5
//
//  Created by abdel on 27/09/2018.
//  Copyright © 2018 Najib ANNABi. All rights reserved.
//

import UIKit

extension UIView {
    
    // Convert To Image
    
    func convertToImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
}
