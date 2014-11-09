//
//  TiqavColor.swift
//  TiqavViewer
//
//  Created by to4iki on 11/9/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import Foundation

enum TiqavColor {
    case main
    
    func toColor() -> UIColor {
        switch self {
        case .main:
            return UIColor(red: CGFloat(0.18), green: CGFloat(0.80), blue: CGFloat(0.44), alpha: CGFloat(1.0))
        default:
            return UIColor.whiteColor()
        }
    }
}