//
//  MainViewController.swift
//  ToDo
//
//  Created by mac on 13/12/2021.
//

import UIKit

class MainViewController: UIViewController {
	@IBOutlet weak var welcomeMsg: UILabel!
	@IBOutlet weak var addTodoButton: UIButton!
	@IBOutlet weak var todoListTableView: UITableView!
	let tableCell = TodoTableViewCell()
	var isTapped: Bool!
	var todos = [String]()
	var name = ""
	override func viewDidLoad() {
        super.viewDidLoad()
		todoListTableView?.dataSource = self
		todoListTableView?.delegate = self
		todos = UserDefaults.standard.stringArray(forKey: "todos") ?? []
		name = UserDefaults.standard.string(forKey: "name") ?? ""
		addTodoButton?.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
		welcomeMsg.text = "Hello \(name)!"
		isTapped = UserDefaults.standard.bool(forKey: "isTapped")
		print(isTapped ?? false)
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		todoConfig()
		todoListTableView?.reloadData()
	}
	private func todoConfig() {
		todos = UserDefaults.standard.array(forKey: "todos") as? [String] ?? []
		UserDefaults.resetStandardUserDefaults()
	}
	@objc func didTapAdd() {
		let createVC = CreateViewController()
		createVC.addTodos = { [weak self] newTodo in
			self?.todos.append(newTodo)
			print(self?.todos ?? [])
			UserDefaults.standard.set(self?.todos, forKey: "todos")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		navigationController?.pushViewController(createVC, animated: true)
	}
	@objc func didTapDelete() {
		UserDefaults.standard.removeObject(forKey: "todos")
		UserDefaults.resetStandardUserDefaults()
		todoListTableView.reloadData()
		print(todos)
	}
}

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		todos.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: "TodoCell",
			for: indexPath) as? TodoTableViewCell else {
			fatalError("unable to dequeue")
		}
		let image = UIImage(systemName: "checkmark.circle.fill")
		let image2 = UIImage(systemName: "checkmark.circle")
		if !(isTapped ?? false) {
			isTapped = true
			UserDefaults.standard.set(isTapped, forKey: "isTapped")
			cell.checkBox.setImage(image, for: .normal)
			cell.checkBox.tintColor = .systemGreen
		} else {
			isTapped = false
			UserDefaults.standard.set(isTapped, forKey: "isTapped")
			cell.checkBox.setImage(image2, for: .normal)
			cell.checkBox.tintColor = .lightGray
		}
		cell.todoLabel.text = todos[indexPath.row]
		cell.didDelete = { [weak self] in
			guard let self = self else { return }
			self.todos.remove(at: indexPath.row)
			UserDefaults.standard.set(self.todos, forKey: "todos")
			UserDefaults.resetStandardUserDefaults()
			self.todoListTableView.reloadData()
	    }
		return cell
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let createVC = CreateViewController()
		createVC.textFieldText = todos[indexPath.row]
		createVC.btnTitle = "Update Todo"
		createVC.addTodos = { [weak self] newTodo in
			self?.todos[indexPath.row] = newTodo
			print(self?.todos ?? [])
			UserDefaults.standard.set(self?.todos, forKey: "todos")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		navigationController?.pushViewController(createVC, animated: true)
	}
}
