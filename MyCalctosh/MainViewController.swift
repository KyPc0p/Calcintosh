//
//  ViewController.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 05.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculator"
        label.font = UIFont(name: "sysfont", size: 60)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private let titleRect: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    private let patternView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "sysfont", size: 45)
        label.textColor = .black
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.text = "1234567890"
        return label
    }()
    
    private let key: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 10 , height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 0
        return view
    }()
    
    private let num: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "sysfont", size: 45)
        label.text = "C"
        return label
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = .black
        view.addSubview(patternView)
        view.addSubview(titleLabel)
        view.addSubview(titleRect)
        view.addSubview(numberView)
        view.addSubview(numberLabel)
        view.addSubview(key)
        view.addSubview(num)
    }
}

//MARK: - Constraints Adjusting
extension MainViewController {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: titleRect.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -3)
        ])
        
        titleRect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRect.heightAnchor.constraint(equalTo: titleRect.widthAnchor),
            titleRect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleRect.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 3),
            titleRect.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: -15)
        ])
        
        patternView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            patternView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        numberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            numberView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 35),
            numberView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -40),
            numberView.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: 120)
        ])
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: numberView.topAnchor, constant: 20),
            numberLabel.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 15),
            numberLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -15),
            numberLabel.bottomAnchor.constraint(equalTo: numberView.bottomAnchor, constant: -20)
        ])
        //...
        key.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            key.topAnchor.constraint(equalTo: numberView.bottomAnchor, constant: 20),
            key.leadingAnchor.constraint(equalTo: titleRect.leadingAnchor),
            key.trailingAnchor.constraint(equalTo: numberView.trailingAnchor,constant: -260),
            key.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -560)
        ])
        
        num.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            num.centerXAnchor.constraint(equalTo: key.centerXAnchor),
            num.centerYAnchor.constraint(equalTo: key.centerYAnchor)
        ])
    }
}



