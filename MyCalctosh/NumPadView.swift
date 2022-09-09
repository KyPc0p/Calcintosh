//
//  NumPadView.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 06.09.2022.
//

import UIKit

class NumPadView: UIView {
    
    let clearButton = NumPadButton()
    let equalButton = NumPadButton()
    let zeroButton = NumPadButton()
    let dotButton = NumPadButton()
    
    lazy var digitsStack: UIStackView = {
        createStack(axis: .vertical, spacing: 30, distrib: .fillEqually) //высота оступа
    }()
    
    lazy var upperLineStack: UIStackView = {
        createStack(axis: .horizontal, spacing: 15, distrib: .fillEqually)
    }()
    
    lazy var rightStack: UIStackView = {
        createStack(axis: .vertical, spacing: 30, distrib: .fillEqually)
    }()
    
    //костыль
    lazy var digitsBottomStack: UIStackView = {
        createStack(axis: .horizontal, spacing: 15, distrib: .fillEqually)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()

        //Проверка
        clearButton.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
        clearButton.setTitle("C", for: .normal)
        
        zeroButton.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
        zeroButton.setTitle("0", for: .normal)
        zeroButton.titleLabel?.textAlignment = .right
        
        equalButton.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
        equalButton.setTitle("=", for: .normal)
        
        dotButton.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
        dotButton.setTitle(".", for: .normal)
    }
    
    //Проверка
    let operation = ["=","/","*","-","+"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setUpView(){
        addSubview(clearButton)
        addSubview(upperLineStack)
        addSubview(dotButton)
        addSubview(zeroButton)
        addSubview(rightStack)
        addSubview(digitsStack)
        addSubview(equalButton)
        
        addButtons(toStack: upperLineStack, buttonsCount: 3, increaseTegBy: 0)
        addButtons(toStack: rightStack, buttonsCount: 2, increaseTegBy: 3)
        addDigitsBlock()
        
        digitsStack.addArrangedSubview(digitsBottomStack)
        addLowerDigitsBlockLine()
    }
    
    func addButtons(toStack stack: UIStackView, buttonsCount: Int, increaseTegBy num: Int) {
        let buttonsPerRow = buttonsCount
        
        for i in 0..<buttonsPerRow {
            let button = NumPadButton()
            button.tag = (i + num)
            button.setTitle(operation[button.tag], for: .normal)
            button.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }
    
    func addLowerDigitsBlockLine(){
        let buttonsPerRow = 3
        var counter = 7
        
        for i in 0..<buttonsPerRow {
            let button = NumPadButton()
            button.setTitle("\(i + 1)", for: .normal)
            button.tag = counter
            button.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
            counter += 1
            digitsBottomStack.addArrangedSubview(button)
        }
    }
    
    func addDigitsBlock() {
        let numberOfRows = 2
        let buttonsPerRow = 3
        var counter = 0
        
        for _ in 0..<numberOfRows {
            
            let HStack = createStack(axis: .horizontal, spacing: 15, distrib: .fillEqually) //ширина оступа
            
            for _ in 0..<buttonsPerRow {
                let button = NumPadButton()
                button.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
                button.tag = counter + 1
                
                if counter >= 3 {
                    button.setTitle("\(counter + 1)", for: .normal)
                } else {
                    button.setTitle("\(counter + 7)", for: .normal)
                }
                HStack.addArrangedSubview(button)
                counter += 1
            }
            digitsStack.addArrangedSubview(HStack)
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
    
    @objc func mocFunc(_ sender: UIButton) {
        print(sender.tag)
    }
    
    //MARK: - Action
    func zeroPressed() {
        
    }
}

//MARK: - Constraints Adjusting
extension NumPadView {
    func setUpConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: topAnchor),
            clearButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            clearButton.bottomAnchor.constraint(equalTo: upperLineStack.bottomAnchor),
            clearButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1), //patternView.heightAnchor
            clearButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
            
        ])
        
        upperLineStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperLineStack.topAnchor.constraint(equalTo: topAnchor),
            upperLineStack.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 15),
            upperLineStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            upperLineStack.heightAnchor.constraint(equalTo: clearButton.heightAnchor)
        ])
        
        
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightStack.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            rightStack.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 30),
            rightStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightStack.bottomAnchor.constraint(equalTo: equalButton.topAnchor, constant: -30)
        ])
        
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equalButton.topAnchor.constraint(equalTo: digitsBottomStack.topAnchor),
            equalButton.leadingAnchor.constraint(equalTo: digitsStack.trailingAnchor, constant: 15),
            equalButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            equalButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        digitsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            digitsStack.topAnchor.constraint(equalTo: upperLineStack.bottomAnchor, constant: 30),
            digitsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            digitsStack.trailingAnchor.constraint(equalTo: rightStack.leadingAnchor, constant: -15),
            digitsStack.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -30)
        ])
        
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dotButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
            dotButton.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            dotButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 15),
            dotButton.trailingAnchor.constraint(equalTo: digitsStack.trailingAnchor),
            dotButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zeroButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
            zeroButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            zeroButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
}

