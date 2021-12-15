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
	var descriptions = [String]()
	var dates = [String]()
	var priorities = [String]()
	var name = ""
	override func viewDidLoad() {
        super.viewDidLoad()
		todoListTableView?.dataSource = self
		todoListTableView?.delegate = self
		todos = UserDefaults.standard.stringArray(forKey: "todos") ?? []
		descriptions = UserDefaults.standard.stringArray(forKey: "descriptions") ?? []
		dates = UserDefaults.standard.stringArray(forKey: "dates") ?? []
		priorities = UserDefaults.standard.stringArray(forKey: "priorities") ?? []
		name = UserDefaults.standard.string(forKey: "name") ?? ""
		addTodoButton?.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
		welcomeMsg.text = "Hello \(name)!"
		isTapped = UserDefaults.standard.bool(forKey: "isTapped")
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		todoConfig()
		todoListTableView?.reloadData()
	}
	private func todoConfig() {
		todos = UserDefaults.standard.array(forKey: "todos") as? [String] ?? []
		descriptions = UserDefaults.standard.array(forKey: "descriptions") as? [String] ?? []
		dates = UserDefaults.standard.array(forKey: "dates") as? [String] ?? []
		priorities = UserDefaults.standard.array(forKey: "priorities") as? [String] ?? []
		UserDefaults.resetStandardUserDefaults()
	}
	@objc func didTapAdd() {
		let createVC = CreateViewController()
		createVC.addTodos = { [weak self] newTodo in
			self?.todos.append(newTodo)
			UserDefaults.standard.set(self?.todos, forKey: "todos")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		createVC.addDescriptions = { [weak self] newDesc in
			self?.descriptions.append(newDesc)
			UserDefaults.standard.set(self?.descriptions, forKey: "descriptions")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		createVC.addDates = { [weak self] newDate in
			self?.dates.append(newDate)
			UserDefaults.standard.set(self?.dates, forKey: "dates")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		createVC.addPriorities = { [weak self] newPriority in
			self?.priorities.append(newPriority)
			UserDefaults.standard.set(self?.priorities, forKey: "priorities")
			UserDefaults.resetStandardUserDefaults()
			self?.todoListTableView.reloadData()
		}
		navigationController?.pushViewController(createVC, animated: true)
	}
	func remove(_ item: [String]) {
		for item in item {
			UserDefaults.standard.removeObject(forKey: item)
		}
		UserDefaults.resetStandardUserDefaults()
		todoListTableView.reloadData()
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
		cell.todoLabel.text = todos[indexPath.row]
		cell.didDelete = { [weak self] in
			guard let self = self else { return }
			self.todos.remove(at: indexPath.row)
			self.descriptions.remove(at: indexPath.row)
			self.dates.remove(at: indexPath.row)
			self.priorities.remove(at: indexPath.row)
			UserDefaults.standard.set(self.todos, forKey: "todos")
			UserDefaults.standard.set(self.descriptions, forKey: "descriptions")
			UserDefaults.standard.set(self.dates, forKey: "dates")
			UserDefaults.standard.set(self.priorities, forKey: "priorities")
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
		createVC.todoFieldText = todos[indexPath.row]
		createVC.descFieldText = descriptions[indexPath.row]
		createVC.priorityText = priorities[indexPath.row]
		createVC.btnTitle = "Update Todo"
		createVC.addTodos = { [weak self] newTodo in
			self?.todos[indexPath.row] = newTodo
			UserDefaults.standard.set(self?.todos, forKey: "todos")
		}
		createVC.addDescriptions = { [weak self] newDesc in
			self?.descriptions[indexPath.row] = newDesc
			UserDefaults.standard.set(self?.descriptions, forKey: "descriptions")
		}
		createVC.addDates = { [weak self] newDate in
			self?.descriptions[indexPath.row] = newDate
			UserDefaults.standard.set(self?.dates, forKey: "dates")
			print(self?.dates)
		}
		createVC.addPriorities = { [weak self] newPriority in
			self?.priorities[indexPath.row] = newPriority
		}
		UserDefaults.resetStandardUserDefaults()
		todoListTableView.reloadData()
		navigationController?.pushViewController(createVC, animated: true)
	}
}
