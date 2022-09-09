//
//  ViewController.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 05.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        createTitle(text: "Calculator", size: 60, color: .white)
    }()
    
    private lazy var titleRect: UIView = {
        createView(backColor: .black, borderColor: UIColor.white.cgColor)
    }()
    
    private lazy var patternView: UIView = {
        createView(backColor: .systemGray4, borderColor: UIColor.clear.cgColor, cRadius: 15)
    }()
    
    lazy var numberView: UIView = {
        createView(backColor: .white, borderColor: UIColor.black.cgColor)
    }()
    
    private lazy var numberLabel: UILabel = {
        createTitle(text: "3", size: 45, color: .black)
    }()
    
    private let numPadView = UIView()
    //NumPad
    
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
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    //MARK: - Methods
    func setupViews(){
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(titleRect)
        view.addSubview(patternView)
        patternView.addSubview(numberView)
        numberView.addSubview(numberLabel)
        patternView.addSubview(numPadView)
        
        //NumPad
        numPadView.addSubview(clearButton)
        numPadView.addSubview(upperLineStack)
        numberView.addSubview(dotButton)
        numPadView.addSubview(zeroButton)
        numPadView.addSubview(rightStack)
        numPadView.addSubview(digitsStack)
        numberView.addSubview(equalButton)
        
        addButtons(toStack: upperLineStack, withCountOfButtons: 3)
        addButtons(toStack: rightStack, withCountOfButtons: 2)
        addDigitsBlock()
        
        digitsStack.addArrangedSubview(digitsBottomStack)
        addLowerDigitsBlockLine()
    }
    
    func createView(backColor: UIColor, borderColor: CGColor, cRadius: CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = backColor
        view.layer.borderColor = borderColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = cRadius
        return view
    }
    
    func createTitle(text: String = "", size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "sysfont", size: size)
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .right
        return label
    }
    //NumPadView methods
    func addButtons(toStack stack: UIStackView, withCountOfButtons count: Int) {
        let buttonsPerRow = count
        
        for _ in 0..<buttonsPerRow {
            let button = NumPadButton()
            stack.addArrangedSubview(button)
        }
    }
    
    func addLowerDigitsBlockLine(){
        let buttonsPerRow = 3
        
        for i in 0..<buttonsPerRow {
            let button = NumPadButton()
            button.setTitle("\(i + 1)", for: .normal)
            button.addTarget(self, action: #selector(mocFunc), for: .touchUpInside)
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
    
    @objc func mocFunc() {
        
    }
}

//MARK: - Constraints Adjusting
extension MainViewController {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleRect.trailingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            titleLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        titleRect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRect.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: -3),
            titleRect.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.6),
            titleRect.widthAnchor.constraint(equalTo: titleRect.heightAnchor),
            titleRect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        patternView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            patternView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        numberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            numberView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 35),
            numberView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -40),
            numberView.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: 110)
        ])
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: numberView.topAnchor, constant: 25),
            numberLabel.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 15),
            numberLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -15),
            numberLabel.bottomAnchor.constraint(equalTo: numberView.bottomAnchor, constant: -20)
        ])
        
        numPadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numPadView.topAnchor.constraint(equalTo: numberView.bottomAnchor, constant: 20),
            numPadView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 40),
            numPadView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -45),
            numPadView.bottomAnchor.constraint(equalTo: patternView.bottomAnchor, constant: -50)
        ])
        
        //NumPad------------
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: numPadView.topAnchor),
            clearButton.leadingAnchor.constraint(equalTo: numPadView.leadingAnchor),
            clearButton.bottomAnchor.constraint(equalTo: upperLineStack.bottomAnchor),
            clearButton.heightAnchor.constraint(equalTo: patternView.heightAnchor, multiplier: 0.1),
            clearButton.widthAnchor.constraint(equalTo: numberView.widthAnchor, multiplier: 0.2)
            
        ])
        
        upperLineStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperLineStack.topAnchor.constraint(equalTo: numPadView.topAnchor),
            upperLineStack.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 15),
            upperLineStack.trailingAnchor.constraint(equalTo: numPadView.trailingAnchor),
            upperLineStack.heightAnchor.constraint(equalTo: clearButton.heightAnchor)
        ])
        
        
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightStack.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            rightStack.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 30),
            rightStack.trailingAnchor.constraint(equalTo: numPadView.trailingAnchor),
            rightStack.bottomAnchor.constraint(equalTo: equalButton.topAnchor, constant: -30)
        ])
        
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equalButton.topAnchor.constraint(equalTo: digitsBottomStack.topAnchor),
            equalButton.leadingAnchor.constraint(equalTo: digitsStack.trailingAnchor, constant: 15),
            equalButton.trailingAnchor.constraint(equalTo: numPadView.trailingAnchor),
            equalButton.bottomAnchor.constraint(equalTo: numPadView.bottomAnchor),
        ])
        
        digitsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            digitsStack.topAnchor.constraint(equalTo: upperLineStack.bottomAnchor, constant: 30),
            digitsStack.leadingAnchor.constraint(equalTo: numPadView.leadingAnchor),
            digitsStack.trailingAnchor.constraint(equalTo: rightStack.leadingAnchor, constant: -15),
            digitsStack.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -30)
        ])
        
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dotButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
            dotButton.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            dotButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 15),
            dotButton.trailingAnchor.constraint(equalTo: digitsStack.trailingAnchor),
            dotButton.bottomAnchor.constraint(equalTo: numPadView.bottomAnchor),
        ])
        
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zeroButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
            zeroButton.leadingAnchor.constraint(equalTo: numPadView.leadingAnchor),
            zeroButton.bottomAnchor.constraint(equalTo: numPadView.bottomAnchor),
        ])
        
    }
}
