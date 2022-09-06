//
//  NumPadView.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 06.09.2022.
//

import UIKit

class NumPadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        addButtonsToStackView()
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
         stackView.spacing = 5
         return stackView
     }()
     
     var HStack: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.spacing = 5
         return stackView
     }()
    
    //MARK: - Methods
    private let numButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: "sysfont", size: 25)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10 , height: 10)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    func setUpView(){
        addSubview(HStack)
    }
    
    func addButtonsToStackView() {
        for i in 1...3 {
            let button = numButton
            button.setTitle("\(i)", for: .normal)
            HStack.addArrangedSubview(button)
        }
    }

    func setUpConstraints() {
        HStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //    private func createNumPad() {
    //        let buttonWidth = view.frame.size.width / 5.148
    //        let buttonHeight = view.frame.size.height / 11.8
    //
    //        let ZeroButton = UIButton(frame: CGRect(x: 0, y: 500, width: buttonWidth*2, height: buttonHeight))
    //        ZeroButton.setTitle("0", for: .normal)
    //
    //        let EqualButton = UIButton(frame:CGRect(x: buttonWidth * 3.43, y: buttonHeight * 5, width: buttonWidth, height: buttonHeight*2))
    //        EqualButton.setTitle("=", for: .normal)
    //
    //        for x in 0..<3 {
    //            let simpleButton = UIButton(frame: CGRect(
    //                x: 200,
    //                y: 200,
    //                width: buttonWidth,
    //                height: buttonHeight
    //            ))
    //            simpleButton.setTitle("\(x + 1)", for: .normal)
    //
    //            simpleButton.setTitleColor(.black, for: .normal)
    //            simpleButton.titleLabel?.font =  UIFont(name: "sysfont", size: 25)
    //            simpleButton.backgroundColor = .white
    //            simpleButton.layer.borderColor = UIColor.black.cgColor
    //            simpleButton.layer.borderWidth = 5
    //            simpleButton.layer.shadowColor = UIColor.black.cgColor
    //            simpleButton.layer.shadowOffset = CGSize(width: 10 , height: 10)
    //            simpleButton.layer.shadowOpacity = 1
    //            simpleButton.layer.shadowRadius = 0
    //
    //            patternView.addSubview(simpleButton)
    //        }
    //
    //
    //        for button in [ZeroButton, EqualButton] {
    //            button.setTitleColor(.black, for: .normal)
    //            button.titleLabel?.font =  UIFont(name: "sysfont", size: 25)
    //            button.backgroundColor = .white
    //            button.layer.borderColor = UIColor.black.cgColor
    //            button.layer.borderWidth = 5
    //            button.layer.shadowColor = UIColor.black.cgColor
    //            button.layer.shadowOffset = CGSize(width: 10 , height: 10)
    //            button.layer.shadowOpacity = 1
    //            button.layer.shadowRadius = 0
    //            patternView.addSubview(button)
    //        }
    //    }
//    }
}

