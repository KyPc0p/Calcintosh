//
//  NumPadView.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 06.09.2022.
//

import UIKit

class NumPadView: UIView {
    
    let zeroButton = NumPadButton()
    let equalButton = NumPadButton()
    
    lazy var mainVStack: UIStackView = {
        createStack(axis: .vertical, spacing: 30, distrib: .fillProportionally) //высота оступа
    }()
    
    lazy var upperVStack: UIStackView = {
        createStack(axis: .vertical, spacing: 30, distrib: .fillEqually) //высота оступа
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setUpView(){
        addSubview(mainVStack)
        createUpperInternalBlock()
        mainVStack.addArrangedSubview(upperVStack)
        upperVStack.backgroundColor = .white
        addSubview(zeroButton)
    }
    
    let keyboard = ["C", "=", "/", "*", "7", "8", "9", "-", "4", "5", "6", "+", "1", "2", "3", "", "", "", ".", "="]
    
    func createUpperInternalBlock() {
        let numberOfRows = 5
        let buttonsPerRow = 4
        var counter = 0
        for _ in 0..<numberOfRows {
            
            let HStack = createStack(axis: .horizontal, spacing: 15, distrib: .fillEqually) //ширина оступа
            
            for _ in 0..<buttonsPerRow {
                let button = NumPadButton()
                button.setTitle(keyboard[counter], for: .normal)
                HStack.addArrangedSubview(button)
                counter += 1
            }
            upperVStack.addArrangedSubview(HStack)
        }
    }
    
    func createStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distrib:UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = distrib
        stackView.spacing = spacing
        return stackView
    }
}

//MARK: - Constraints Adjusting
extension NumPadView {
    func setUpConstraints() {
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainVStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zeroButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            zeroButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            zeroButton.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 73.4),
            zeroButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -94)
        ])
    }
}

