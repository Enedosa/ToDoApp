//
//  ViewController.swift
//  ToDo
//
//  Created by Decagon on 13/12/2021.
//

import UIKit

class OnboardingViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
	
	@IBOutlet weak var nextButton: UIButton!
	
	let mainVC = MainViewController()
	
	var name: String = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
		name = UserDefaults.standard.string(forKey: "name") ?? ""
		print(name)
		if name != "" {
			nameTextField.text = name
		}
		nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
	
	@objc func didTapNext() {
		let mainVC = MainViewController()
		guard let text = nameTextField.text, !text.isEmpty, text != " " else { return }
		name = text
		UserDefaults.standard.set(name, forKey: "name")
		navigationController?.pushViewController(mainVC, animated: true)
	}

}

