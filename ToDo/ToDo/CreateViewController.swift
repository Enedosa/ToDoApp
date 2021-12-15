//
//  CreateViewController.swift
//  ToDo
//
//  Created by mac on 13/12/2021.
//

import UIKit

class CreateViewController: UIViewController {
	var addTodos: ((String) -> Void)?
	var addDescriptions: ((String) -> Void)?
	var addDates: ((String) -> Void)?
	var addPriorities: ((String) -> Void)?
	var todoFieldText = ""
	var descFieldText = ""
	var date = ""
	var priorityText = ""
	var btnTitle = "Create"
	var todos = [String]()
<<<<<<< HEAD
	var descriptions = [String]()
	var priority = [String]()
=======
   
    
>>>>>>> dev
	let todoTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Title"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title3)
		return label
	}()
	let todoTitleTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter your todo"
        textField.backgroundColor = UIColor(named: "colorTodo")
		textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.masksToBounds = true
        textField.textColor = .white
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Description"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title3)
		return label
	}()
	let descriptionTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 15.0
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.masksToBounds = true
        textView.backgroundColor = UIColor(named: "colorTodo")
		return textView
	}()
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Day"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title3)
		return label
	}()
	let datePickerView: UIDatePicker = {
		let picker = UIDatePicker()
		picker.datePickerMode = .date
		picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(named: "colorTodo")
        picker.layer.cornerRadius = 15.0
        picker.layer.borderWidth = 2.0
        picker.layer.borderColor = UIColor.darkGray.cgColor
        picker.layer.masksToBounds = true
		return picker
	}()
	let priorityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "priority:"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title3)
		return label
	}()
	let priorityPicker: UITextField = {
		let textField = UITextField()
		textField.loadDropdownData(data: ["High", "Medium", "Low"])
		textField.borderStyle = .roundedRect
		textField.textAlignment = .right
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.backgroundColor = UIColor(named: "colorTodo")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	lazy var addButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 24)
		button.backgroundColor = UIColor(named: "colorTodo")
		button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
		return button
	}()
	override func viewDidLoad() {
		print(date)
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		updateScreenConfig()
		layoutConstraints()
	}
	private func updateScreenConfig() {
		self.todoTitleTextField.text = todoFieldText
		self.descriptionTextView.text = descFieldText
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yy"
		if let newDate = dateFormatter.date(from: date) {
			datePickerView.date = newDate
		}
		self.datePickerView.setDate(dateFormatter.date(from: date) ?? datePickerView.date, animated: true)
		self.priorityPicker.text = priorityText
		self.addButton.setTitle(btnTitle, for: .normal)
	}
	private func layoutConstraints() {
		view.addSubview(todoTitleLabel)
		view.addSubview(todoTitleTextField)
		view.addSubview(descriptionLabel)
		view.addSubview(descriptionTextView)
		view.addSubview(dateLabel)
		view.addSubview(datePickerView)
		view.addSubview(priorityLabel)
		view.addSubview(priorityPicker)
		view.addSubview(addButton)
		todoTitleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
			constant: 20).isActive = true
		todoTitleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
			multiplier: 0.95).isActive = true
		todoTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
		todoTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		todoTitleTextField.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor,
			constant: 10).isActive = true
		todoTitleTextField.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor).isActive = true
		todoTitleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
		todoTitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: todoTitleTextField.bottomAnchor,
			constant: 20).isActive = true
		descriptionLabel.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
			constant: 10).isActive = true
		descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
			constant: 10).isActive = true
		descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
			constant: 10).isActive = true
		descriptionTextView.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor).isActive = true
		descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		dateLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20).isActive = true
		dateLabel.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor, multiplier: 0.4).isActive = true
		dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		dateLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		dateLabel.trailingAnchor.constraint(equalTo: datePickerView.leadingAnchor, constant: 10).isActive = true
		datePickerView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20).isActive = true
		datePickerView.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor, multiplier: 0.6).isActive = true
		datePickerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		datePickerView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10).isActive = true
		datePickerView.trailingAnchor.constraint(
			equalTo: view.layoutMarginsGuide.trailingAnchor,
			constant: 10).isActive = true
		priorityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
		priorityLabel.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor, multiplier: 0.4).isActive = true
		priorityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		priorityLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		priorityLabel.trailingAnchor.constraint(equalTo: priorityPicker.leadingAnchor, constant: 10).isActive = true
		priorityPicker.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 20).isActive = true
		priorityPicker.widthAnchor.constraint(equalTo: todoTitleLabel.widthAnchor, multiplier: 0.6).isActive = true
		priorityPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
		priorityPicker.leadingAnchor.constraint(equalTo: priorityLabel.trailingAnchor, constant: 10).isActive = true
		priorityPicker.trailingAnchor.constraint(
			equalTo: view.layoutMarginsGuide.trailingAnchor,
			constant: 10).isActive = true
		addButton.topAnchor.constraint(equalTo: priorityPicker.bottomAnchor, constant: 60).isActive = true
		addButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
		addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	@objc func didTapAdd() {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		let pickerDate = formatter.string(from: datePickerView.date)
		guard let text = todoTitleTextField.text,
			  let desc = descriptionTextView.text,
			  let priority = priorityPicker.text,
				!text.isEmpty,
				text != " " else { return }
		addTodos?(text)
		addDescriptions?(desc)
		addDates?(pickerDate)
		addPriorities?(priority)
		navigationController?.popViewController(animated: true)
	}

}
