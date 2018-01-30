//
//  CursusView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class CursusView: UIView {
    
    @IBOutlet weak var cursusPickerView: UIPickerView!
    
    weak var student: Student? {
        didSet {
            cursusPickerView.reloadAllComponents()
        }
    }
    
}

extension CursusView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return student == nil ? 0 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return student?.cursus.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return student?.cursus[row].name
    }
    
}
