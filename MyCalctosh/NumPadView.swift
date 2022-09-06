//
//  NumPadView.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 06.09.2022.
//

import UIKit

class NumButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        setTitleColor(.black, for: .normal)
        titleLabel?.font =  UIFont(name: "sysfont", size: 45)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 10 , height: 10)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
    }
}

class NumPadView: UIView {
    private lazy var numButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: "sysfont", size: 25)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10 , height: 10)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtonsToStackView()
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - StackViews
     var VStack: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .vertical
         stackView.distribution = .fillEqually
         stackView.spacing = 10
//         stackView.backgroundColor = .yellow
         return stackView
     }()
     
     var HStack: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.spacing = 15
//         stackView.backgroundColor = .cyan    //цвет
         return stackView
     }()
    
    //MARK: - Methods
    func setUpView(){
        addSubview(HStack)
        HStack.addSubview(VStack)
    }
    
    func addButtonsToStackView() {
        for i in 1...3 {
            let button = NumButton()
            button.setTitle("\(i)", for: .normal)
            HStack.addArrangedSubview(button)
        }
    }

    func setUpConstraints() {
        HStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            HStack.topAnchor.constraint(equalTo: topAnchor),
            HStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            HStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            HStack.bottomAnchor.constraint(equalTo: topAnchor, constant: 75)
        ])
        
        VStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: topAnchor),
            VStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

