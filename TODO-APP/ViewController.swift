//
//  ViewController.swift
//  TODO-APP
//
//  Created by ebpearls on 6/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var contents: [TodoList] = []

    //MARK: - UI Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let addButtonImage = UIImage(systemName: "plus")
        button.setImage(addButtonImage, for: .normal)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.backgroundColor = .systemTeal
        navigationItem.title = "Todo App"
        
        
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    @objc func addButtonTapped(){
        let vc = AddViewController()
        
        vc.delegate = self
        
        vc.onTaskClosure = { [weak self] todoTask in
            guard let self = self else { return }
            
            self.contents.append(todoTask)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
    
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView DataSource & Delegate

extension ViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The tableView could not deque a custom cell in viewController. ")
        }
        
        let todo = contents[indexPath.row]
        
        cell.configure(with: todo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tobeeditedtask = contents[indexPath.row]
        
        editvc(task: tobeeditedtask, index: indexPath.row)
        
        // delegate
        // closure / completion handler
        
        push(editvc)
        
    }
    
}

extension ViewController: AddViewControllerManageable {
    func onCreateTask(task: TodoList) {
        self.contents.append(task)
        
//        contents[replaceIndex] = task
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ViewController: EditViewControllerManageable {
    func onEditTask(task: TodoList, index: int) {
//        self.contents.append(task)
        
        contents[index] = task
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

