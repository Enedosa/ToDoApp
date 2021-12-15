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
	var addDates: ((Date) -> Void)?
	var addPriorities: ((String) -> Void)?
	var todoFieldText = ""
	var descFieldText = ""
	var priorityText = ""
	var btnTitle = "Create"
	var todos = [String]()
	var descriptions = [String]()
	var priority = [String]()
	let todoTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Title:"
		return label
	}()
	let todoTitleTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter your todo"
		textField.borderStyle = .roundedRect
		textField.layer.cornerRadius = 5
		textField.layer.borderWidth = 0.5
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Description:"
		return label
	}()
	let descriptionTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.layer.cornerRadius = 5
		textView.layer.borderWidth = 0.5
		return textView
	}()
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Day:"
		return label
	}()
	let datePickerView: UIDatePicker = {
		let picker = UIDatePicker()
		picker.datePickerMode = .date
		picker.translatesAutoresizingMaskIntoConstraints = false
		return picker
	}()
	let priorityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "priority:"
		return label
	}()
	let priorityPicker: UITextField = {
		let textField = UITextField()
		textField.loadDropdownData(data: ["High", "Medium", "Low"])
		textField.borderStyle = .roundedRect
		textField.textAlignment = .right
		textField.layer.cornerRadius = 5
		textField.layer.borderWidth = 0.5
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
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		self.todoTitleTextField.text = todoFieldText
		self.descriptionTextView.text = descFieldText
		self.priorityPicker.text = priorityText
		self.addButton.setTitle(btnTitle, for: .normal)
		layoutConstraints()
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
		todoTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
		guard let text = todoTitleTextField.text,
			  let desc = descriptionTextView.text,
			  let priority = priorityPicker.text,
				!text.isEmpty,
				text != " " else { return }
		addTodos?(text)
		addDescriptions?(desc)
		addPriorities?(priority)
		navigationController?.popViewController(animated: true)
	}

}
