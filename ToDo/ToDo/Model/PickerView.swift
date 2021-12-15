//
//  PickerView.swift
//  Carbon-Clone
//
//  Created by mac on 07/12/2021.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	var pickerData: [ String ]!
	var pickerTextField: UITextField!
	init(pickerData: [ String ], dropdownField: UITextField) {
		super.init(frame: CGRect.zero)
		self.pickerData = pickerData
		self.pickerTextField = dropdownField
		self.delegate = self
		self.dataSource = self
		DispatchQueue.main.async {
			if pickerData.count > 0 {
				self.pickerTextField.isEnabled = true
			} else {
				self.pickerTextField.text = nil
				self.pickerTextField.isEnabled = false
			}
		}
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerData[row]
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		pickerTextField.text = pickerData[row]
		pickerTextField.resignFirstResponder()
		pickerTextField.endEditing(true)
	}

}
