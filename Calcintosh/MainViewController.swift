//
//  ViewController.swift
//  Calcintosh
//
//  Created by Артём Харченко on 05.09.2022.
//

import UIKit

protocol NumPadViewDelegate: AnyObject {
    func numButtonPressed(withValue value: String)
    func operationPressed(withTag tag: Int)
    func clearButtonPressed()
}

enum Operation {
    case add, subtract, miltiply, devide
}

class MainViewController: UIViewController {
    
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var currentOperation: Operation?
    private var operationIsActive = false
    
    private lazy var titleLabel = createTitle(text: "Calculator", size: 60, color: .white)
    private lazy var titleRect = createView(backColor: .black, borderColor: UIColor.white.cgColor)
    private lazy var patternView = createView(backColor: .systemGray4, borderColor: UIColor.clear.cgColor, cRadius: 15)
    private lazy var resultView = createView(backColor: .white, borderColor: UIColor.black.cgColor)
    private lazy var resultLabel = createTitle(text: "0", size: 45, color: .black)
    private let numPadView = NumPadView()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        numPadView.mainVCDelegate = self
    }
    
    //MARK: - Methods
    private func setupViews(){
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(titleRect)
        view.addSubview(patternView)
        patternView.addSubview(resultView)
        resultView.addSubview(resultLabel)
        patternView.addSubview(numPadView)
    }
    
    private func createView(backColor: UIColor, borderColor: CGColor, cRadius: CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = backColor
        view.layer.borderColor = borderColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = cRadius
        return view
    }
    
    private func createTitle(text: String = "", size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "sysfont", size: size)
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.textAlignment = .right
        return label
    }
}

//MARK: - NumPadViewDelegate
extension MainViewController: NumPadViewDelegate {
    
    func numButtonPressed(withValue value: String) {
        if operationIsActive == false {
            
            if value == ".", let text = resultLabel.text, text.contains(value) {
                return
            } else {
                if resultLabel.text == "0" {
                    dotChange(value)
                } else if let text = resultLabel.text {
                    resultLabel.text = "\(text)\(value)"
                }
            }
            
        } else {
            dotChange(value)
            operationIsActive = false
        }
        
    }
    
    func operationPressed(withTag tag: Int) {
        operationIsActive = true
        
        if let text = resultLabel.text, let value = Double(text), firstNumber == 0 {
                firstNumber = value
        }
        
        if tag == 0 {
            equalOperation(with: tag)
        }else if tag == 1 {
            currentOperation = .devide
        }else if tag == 2 {
            currentOperation = .miltiply
        }else if tag == 3 {
            currentOperation = .subtract
        }else if tag == 4 {
            currentOperation = .add
        }
    }
    
    func equalOperation(with tag: Int) {
        if let operation = currentOperation {
            var second: Double = 0
            
            if let text = resultLabel.text, let value = Double(text) {
                second = value
                secondNumber = second
            }
            
            switch operation {
            case .devide:
                resultLabel.text = "\(firstNumber / second)"
            case .miltiply:
                resultLabel.text = "\(firstNumber * second)"
            case .subtract:
                resultLabel.text = "\(firstNumber - second)"
            case .add:
                resultLabel.text = "\(firstNumber + second)"
            }
            
            if tag == 0 {
                firstNumber = 0
            } else if let text = resultLabel.text, let value = Double(text) {
                firstNumber = value
            }
        }
    }
    
    func clearButtonPressed() {
        resultLabel.text = "0"
        
        if operationIsActive == false {
            operationIsActive = true
        } else {
            currentOperation = nil
            firstNumber = 0
        }
    }
    
    func dotChange(_ value: String) {
        if value == "." {
            resultLabel.text = "0\(value)"
        } else {
            resultLabel.text = value
        }
    }
}
    
    //MARK: - Constraints
extension MainViewController {
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
            patternView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            resultView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 35),
            resultView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -40),
            resultView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        ])
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 15),
            resultLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -15),
            resultLabel.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -15)
        ])
        
        numPadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numPadView.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 20),
            numPadView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 40),
            numPadView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -45),
            numPadView.bottomAnchor.constraint(equalTo: patternView.bottomAnchor, constant: -35)
        ])
    }
}
