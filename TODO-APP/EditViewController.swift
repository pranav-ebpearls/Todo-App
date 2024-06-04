//
//  EditViewController.swift
//  TODO-APP
//
//  Created by ebpearls on 6/4/24.
//

import UIKit
protocol EditViewControllerManageable {
    func onEditTask(task: TodoList, index: Int)//, index: Int)
}

class EditViewController: UIViewController, UITextFieldDelegate {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemTeal
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitButtonTappedd), for: .touchUpInside)
        return button
    }()
    
    private let textFieldLabel: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.borderStyle = .line
        textField.textColor = .black
        textField.keyboardType = .default
        textField.font = .systemFont(ofSize: 24, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    var editTaskClosuree: ((TodoList, Int) -> Void)?
    
    var delegate: EditViewControllerManageable?
    
    private var task: TodoList
    private var index: Int
    
    init(task: TodoList, index: Int) {
        self.task = task
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
//    func get(task: TodoList, index: Int) {
//        self.task = task
//        self.index = index
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        textFieldLabel.delegate = self
        
        textFieldLabel.text = task.body
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.backgroundColor = .systemTeal
        navigationItem.title = "Edit"
        
        self.view.addSubview(textFieldLabel)
        self.view.addSubview(submitButton)
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            textFieldLabel.heightAnchor.constraint(equalToConstant: 100),
            textFieldLabel.widthAnchor.constraint(equalToConstant: 300),
            textFieldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 275),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 115),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
    }
    
    @objc func submitButtonTappedd() {
        guard let title = textFieldLabel.text else { return }
        
        task.body = title
        
  
        delegate?.onEditTask(task: task, index: index)
        
//        editTaskClosuree?(task, index)
        navigationController?.popViewController(animated: true)
    }
    
}
