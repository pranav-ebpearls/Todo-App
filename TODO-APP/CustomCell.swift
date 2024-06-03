//
//  CustomCell.swift
//  TODO-APP
//
//  Created by ebpearls on 6/3/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
//    private let addButton: UIButton = {
//        let button = UIButton(type: .custom)
//        let addButtonImage = UIImage(systemName: "plus")
//        button.setImage(addButtonImage, for: .normal)
//        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sideCheckBox: UIButton = {
        let checkBox =  UIButton (type: .custom)

        let checked = UIImage(systemName: "checkmark.square")
        let unchecked = UIImage(systemName: "square")
        
        
        checkBox.setImage(unchecked, for: .normal);
        checkBox.setImage(checked, for: .selected);
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(sideCheckBox)
//        self.contentView.addSubview(addButton)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            sideCheckBox.widthAnchor.constraint(equalToConstant: 30),
            sideCheckBox.heightAnchor.constraint(equalToConstant: 30),
            sideCheckBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sideCheckBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
//            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
        
        
    }
    
    @objc func checkBoxTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
//    @objc func addButtonTapped(_ sender: UIButton){
//        
//    }
    
    func configure(with todo: TodoList) {
        titleLabel.text = todo.body
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        dateLabel.text = formattedDate
    } 
}
