//
//  NumPadView.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 06.09.2022.
//

import UIKit

class NumPadView: UIView {
    
    weak var mainVCDelegate: MainViewControllerDeleagte?

    private let operations = ["=","/","*","-","+"]  //нужны ли тут?
    
    private let clearButton = NumPadButton()
    private let equalButton = NumPadButton()
    private let zeroButton = NumPadButton()
    private let dotButton = NumPadButton()
    
    private lazy var digitsStack = createStack(axis: .vertical, spacing: 30)
    private lazy var upperLineStack = createStack(axis: .horizontal, spacing: 15)
    private lazy var rightStack = createStack(axis: .vertical, spacing: 30)
    private lazy var digitsUpperStack = createStack(axis: .horizontal, spacing: 15)
    private lazy var digitsBottomStack = createStack(axis: .horizontal, spacing: 15)
    private lazy var digitsCenterStack = createStack(axis: .horizontal, spacing: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        setUpActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setUpView(){
        setupSubViews(clearButton, upperLineStack, dotButton, zeroButton, rightStack, digitsStack, equalButton)
        addDigitsBlock()
        addButtons(toStack: upperLineStack, buttonsCount: 3, increaseTegBy: 0)
        addButtons(toStack: rightStack, buttonsCount: 2, increaseTegBy: 3)
    }
    
    func setUpActions() {
        dotButton.setTitle(".", for: .normal)
        dotButton.addTarget(self, action: #selector(dotButtonPressed(_:)), for: .touchUpInside)
        
        zeroButton.setTitle("0", for: .normal)
        zeroButton.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        clearButton.setTitle("C", for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonPressed(_:)), for: .touchUpInside)
        
        equalButton.setTitle("=", for: .normal)
        equalButton.addTarget(self, action:#selector(operationButtonPressed), for: .touchUpInside)
    }

    func addDigitsBlock() {
        var counter = 1
        
        for stack in [digitsUpperStack, digitsCenterStack, digitsBottomStack] {
            
            for _ in 0..<3 {
                let button = NumPadButton()
                
                if counter >= 7 {
                    button.setTitle("\(counter - 6)", for: .normal)
                } else if counter >= 4 {
                    button.setTitle("\(counter)", for: .normal)
                } else {
                    button.setTitle("\(counter + 6)", for: .normal)
                }
                
                button.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
                stack.addArrangedSubview(button)
                counter += 1
            }
            digitsStack.addArrangedSubview(stack)
        }
    }
    
    func createStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }
    
    func addButtons(toStack stack: UIStackView, buttonsCount: Int, increaseTegBy num: Int) {
        let buttonsPerRow = buttonsCount
        
        for i in 0..<buttonsPerRow {
            let button = NumPadButton()
            button.tag = (i + num)
            button.setTitle(operations[button.tag], for: .normal)
            button.addTarget(self, action: #selector(operationButtonPressed), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }
    
    func setupSubViews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    //MARK: - Actions
    @objc private func numButtonPressed(_ sender: UIButton) {  //проверяет на 0 и добавляет числа(так же должна проверять на .)
        mainVCDelegate?.numButtonPressed(withValue: sender.titleLabel?.text ?? "Error")
    }
    
    @objc private func operationButtonPressed(_ sender: UIButton) {  //должен быть тег
        mainVCDelegate?.operationPressed(withTag: sender.tag)
    }
    
    @objc private func dotButtonPressed(_ sender: UIButton) {  
        mainVCDelegate?.dotButtonPressed()
    }
    
    @objc private func clearButtonPressed(_ sender: UIButton) {  //должна отчищать, присваивать операции nill, делать firstNumber = 0
        mainVCDelegate?.clearButtonPressed()
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
            clearButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            clearButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2155)
            //(UIScreen.main.bounds.height - (30*4)) / 5)
            //(UIScreen.main.bounds.width - (15*3)) / 5)
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

