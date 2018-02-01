//
//  DoubleExtensions.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 2/1/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

extension Double {
    
    var integerPart: Double {
        return Double(Int(self))
    }
    
    var decimalPart: Double {
        return self - self.integerPart
    }
}
