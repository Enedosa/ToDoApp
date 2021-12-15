//
//  TodoTableViewCell.swift
//  ToDo
//
//  Created by mac on 13/12/2021.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

	@IBOutlet weak var checkBox: UIButton!
	@IBOutlet weak var deleteButton: UIButton!
	@IBOutlet weak var todoLabel: UILabel!
	var isTapped: Bool?
	var didDelete: () -> Void  = { }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
		checkBox.addTarget(self, action: #selector(didTapComplete), for: .touchUpInside)
    }
	@objc func didTapDelete() {
		didDelete()
	}
	@objc func didTapComplete() {
		let image = UIImage(systemName: "checkmark.circle.fill")
		let image2 = UIImage(systemName: "checkmark.circle")
		if !(isTapped ?? false) {
			isTapped = true
			UserDefaults.standard.set(isTapped, forKey: "isTapped")
			checkBox.setImage(image, for: .normal)
			checkBox.tintColor = .systemGreen
		} else {
			isTapped = false
			UserDefaults.standard.set(isTapped, forKey: "isTapped")
			checkBox.setImage(image2, for: .normal)
			checkBox.tintColor = .lightGray
		}
	}
}
