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
    
    private lazy var numberView: UIView = {
        createView(backColor: .white, borderColor: UIColor.black.cgColor)
    }()
    
    private lazy var numberLabel: UILabel = {
        createTitle(text: "3", size: 45, color: .black)
    }()
    
    let numPadView = NumPadView()
    
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
        
        numPadView.backgroundColor = .darkGray
        
        patternView.addSubview(numPadView)
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
     
        return label
    }
}

//MARK: - Constraints Adjusting
extension MainViewController {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: titleRect.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45)
        ])
        
        titleRect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRect.heightAnchor.constraint(equalTo: titleRect.widthAnchor),
            titleRect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleRect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleRect.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: -15)
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
            numPadView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 45),
            numPadView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -45),
            numPadView.bottomAnchor.constraint(equalTo: patternView.bottomAnchor, constant: -50)
        ])
        
    }
}
