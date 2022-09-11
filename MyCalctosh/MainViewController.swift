//
//  ViewController.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 05.09.2022.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
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
        label.minimumScaleFactor = 0.7
        label.textAlignment = .right
        return label
    }
    
    func dotButtonCheck(_ value: String) {
        if value == "." {
            resultLabel.text = "0\(value)"
        } else {
            resultLabel.text = value
        }
    }
}

//MARK: - MainViewControllerDelegate
extension MainViewController: MainViewControllerDelegate {
    func numButtonPressed(withValue value: String) {
        
        if operationIsActive == false {
            if resultLabel.text == "0" {
                dotButtonCheck(value)
                print("проверка цифры \(value), операция НЕ Активна: равна 0")
            } else if let text = resultLabel.text {
                resultLabel.text = "\(text)\(value)"
                print("проверка цифры \(value), операция НЕ Активна: равна имеет текст")
            }
        } else {
            dotButtonCheck(value)
            operationIsActive = false
            print("проверка цифры \(value), операция Активна: заменяем значение на первое введённое")
            print("проверка \(currentOperation)")
            print("операция НЕ Активна")
        }
        
        print("на момент нажатия \(value) first \(firstNumber), second \(secondNumber) ")
        
    }
    
    //Главная проблема - на момент нажатия 1 + 2 + (после нажатия +, выводится правильная сумма - 3), затем правильно вводится нажатое число
    //!НО! firstNumber = 0, а должен - прошлому числу
    //поэтому следующая операция не меняет число
    func operationPressed(withTag tag: Int) {
        operationIsActive = true
        var myTag = tag
        
        if let text = resultLabel.text, let value = Double(text) {
            if firstNumber == 0 {
                firstNumber = value
                print("Если firstNumber = 0 ->добавили firstNumber \(firstNumber), а second = \(secondNumber)")
            } else {
                myTag = 0
                print(currentOperation)
                print("переключение на = с тега \(tag)")
            }
        }
        
        if currentOperation != nil {  //???
            print(" currentOperation НЕ РАВНО nil ")
            print(currentOperation)
        } else {
            print(currentOperation)
            print(" currentOperation РАВНО nil ")  //когда выполняем первое действие 5 + 1 -> Равно nil
        }
        
        if myTag == 0 {
            if let operation = currentOperation {
                var second: Double = 0
                secondNumber = second
                if let text = resultLabel.text, let value = Double(text) {  //Не правильная логика тк при == добовляет тот же номер в second
                    second = value
                    
                    print("firstNumber \(firstNumber), Добавили second = \(secondNumber)")
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
                
                firstNumber = 0
//                currentOperation = nil
                
                print(firstNumber)
                print(secondNumber)
            }
        }else if myTag == 1 {
            currentOperation = .devide
        }else if myTag == 2 {
            currentOperation = .miltiply
        }else if myTag == 3 {
            currentOperation = .subtract
        }else if myTag == 4 {
            currentOperation = .add
        }
    }
    
    func clearButtonPressed() { //не сбрасывает, должна отчищать 1 число на первое нажатие
        resultLabel.text = "0"
        
        print("С/очищаем Label = 0")
        if operationIsActive == false {
            operationIsActive = true
            print("С/операция НЕ Активна: присваеваем Активна ")
        } else {
            currentOperation = nil
            firstNumber = 0
            print("С/операция Активна: очищаем currentOperation")
        }
        
        print("\(firstNumber)")
        print("\(secondNumber)")
    }
}

//MARK: - Constraints
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
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            resultView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 35),
            resultView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -40),
            resultView.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: 110)
        ])
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 25),
            resultLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 15),
            resultLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -15),
            resultLabel.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -20)
        ])
        
        numPadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numPadView.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 20),
            numPadView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 40),
            numPadView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -45),
            numPadView.bottomAnchor.constraint(equalTo: patternView.bottomAnchor, constant: -50)
        ])
    }
}
