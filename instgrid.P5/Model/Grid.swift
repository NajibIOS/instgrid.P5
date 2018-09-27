//
//  Grid.swift
//  instgrid.P5
//
//  Created by abdel on 09/08/2018.
//  Copyright © 2018 Najib ANNABi. All rights reserved.
//

import Foundation

enum Grid {
    case pattern1
    case pattern2
    case pattern3
    
    var display: [Bool] {
        switch self {
        case .pattern1:
            return [false, true, false, false]
        case .pattern2:
            return [false, false, false, true]
        case .pattern3:
            return [false, false, false, false]
            
        }
    }
}
