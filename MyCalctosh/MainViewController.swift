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
        label.font = UIFont(name: "sysfont", size: 50)
        label.textColor = .white
        return label
    }()
    
    private let patternView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let numView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    private let numLabel: UILabel = {
        let label = UILabel()
        label.text = "1488"
        label.font = UIFont(name: "sysfont", size: 50)
        label.textColor = .black
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
        view.addSubview(numView)
    }
    
    func setuNumberPad() {
        //        let buttonSize = view.frame.size.width / 4
    }
    
    func buttonAdjustments(button: UIView){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10 , height: 10)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 4
    }
}

//MARK: - Constraints Adjusting
extension MainViewController {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        patternView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            patternView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
        
        numView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            numView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 30),
            numView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -35),
            numView.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: 100)
            
        ])
    }
}



