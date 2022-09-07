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
        layer.shadowOffset = CGSize(width: 7 , height: 7)
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
        createUpperInternalBlock()
        createLowerInternalBlock()
        createRightBlockVStack()
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - StackViews
    lazy var mainHStack = createStack(axis: .horizontal, spacing: 20, distribution: .fillEqually)
    lazy var upperInternalBlockVStack = createStack(axis: .vertical, spacing: 10, distribution: .fillEqually)
    
    //MARK: - Methods
    func createUpperInternalBlock() {
        let numberOfRows = 4
        let buttonsPerRow = [3,3,3,3]
        
        var counter = 1
        for i in 0..<numberOfRows {
            let HStack = createStack(axis: .horizontal, spacing: 15, distribution: .fillEqually)
            HStack.translatesAutoresizingMaskIntoConstraints = false
            HStack.backgroundColor = UIColor.yellow
            for _ in 0..<buttonsPerRow[i] {
                let button = NumButton()
                button.setTitle("\(counter)", for: .normal)
                HStack.addArrangedSubview(button)
                counter += 1
            }
            upperInternalBlockVStack.addArrangedSubview(HStack)
        }
    }
    
    func createLowerInternalBlock(){
        let numberOfRows = 1
        let buttonsPerRow = [2]
        var counter = 13

        for i in 0..<numberOfRows {
            let lowHStack = createStack(axis: .horizontal, spacing: 10, distribution: .fillEqually)
            lowHStack.backgroundColor = UIColor.red
            lowHStack.translatesAutoresizingMaskIntoConstraints = false
            for _ in 0..<buttonsPerRow[i] {
                let button = NumButton()
                button.setTitle("\(counter)", for: .normal)
                lowHStack.addArrangedSubview(button)
                counter += 1
            }
            upperInternalBlockVStack.addArrangedSubview(lowHStack)
        }
    }
    
    func createRightBlockVStack(){
        let numberOfRows = 1
        let buttonsPerRow = [4]
        var counter = 15

        for i in 0..<numberOfRows {
            let rightVStack = createStack(axis: .vertical, spacing: 10, distribution: .fillEqually)
            rightVStack.backgroundColor = UIColor.orange
            rightVStack.translatesAutoresizingMaskIntoConstraints = false
            for _ in 0..<buttonsPerRow[i] {
                let button = NumButton()
                button.setTitle("\(counter)", for: .normal)
                rightVStack.addArrangedSubview(button)
                counter += 1
            }
            mainHStack.addArrangedSubview(rightVStack)
        }
    }
    
    func createStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution:UIStackView.Distribution  ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
    
    func setUpView(){
        addSubview(mainHStack)
        mainHStack.addArrangedSubview(upperInternalBlockVStack)
        
    }

    func setUpConstraints() {
        mainHStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainHStack.topAnchor.constraint(equalTo: topAnchor),
            mainHStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        upperInternalBlockVStack.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
