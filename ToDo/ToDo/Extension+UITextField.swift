//
//  TextFieldExtension.swift
//  Carbon-Clone
//
//  Created by mac on 07/12/2021.
//

import UIKit

extension UITextField {
	func loadDropdownData(data: [String]) {
	   self.inputView = PickerView(pickerData: data, dropdownField: self)
	}
	func iconRight() {
		let btnImage = UIImage(systemName: "chevron.down")
		let button = UIButton(frame: CGRect(x: 0, y: 10, width: 15, height: 10))
		button.setImage(btnImage, for: .normal)
		button.tintColor = .black
		let iconViewContainer: UIView = UIView(frame: CGRect(x: 20, y: 20, width: 40, height: 30))
		iconViewContainer.addSubview(button)
		rightView = iconViewContainer
		rightViewMode = .always
	}

	func iconLeft(_ image: UIImage) {
		let iconView = UIImageView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
		iconView.image = image
		let iconViewContainer: UIView = UIView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
		iconViewContainer.addSubview(iconView)
		leftView = iconViewContainer
		leftViewMode = .always
	}
	func imageIconRight(_ image: UIImage) {
		let btnImage = UIImage(systemName: "chevron.down")
		let button = UIButton(frame: CGRect(x: 30, y: 10, width: 15, height: 10))
		button.setImage(btnImage, for: .normal)
		button.tintColor = .black
		let flagView = UIImageView(frame: CGRect(x: -10, y: 5, width: 30, height: 20))
		flagView.image = image
		flagView.tintColor = .black
		let iconViewContainer: UIView = UIView(frame: CGRect(x: 20, y: 20, width: 80, height: 30))
		iconViewContainer.addSubview(button)
		iconViewContainer.addSubview(flagView)
		rightView = iconViewContainer
		rightViewMode = .always
	}

}
