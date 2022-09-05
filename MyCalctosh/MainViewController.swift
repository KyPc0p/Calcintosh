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
        label.font = UIFont(name: "sysfont", size: 65)
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
        label.font = UIFont(name: "sysfont", size: 40)
        label.textColor = .black
        label.textAlignment = .right
        label.text = "12345"
        return label
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
//        drawRect()
    }
    
    func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.03589498624, green: 0.0935928002, blue: 0.08751047403, alpha: 1)
        view.addSubview(patternView)
        view.addSubview(titleLabel)
        view.addSubview(titleRect)
        view.addSubview(numberView)
        view.addSubview(numberLabel)
    }
    
//    func drawRect() {
//        let render = UIGraphicsImageRenderer(size: CGSize(width: 45, height: 45))
//
//        let image = render.image { ctx in
//            let rectangle = CGRect(x: 0, y: 0, width: 45, height: 45)
//            ctx.cgContext.setFillColor(UIColor.black.cgColor)
//            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
//            ctx.cgContext.setLineWidth(6)
//
//            ctx.cgContext.addRect(rectangle)
//            ctx.cgContext.drawPath(using: .fillStroke)
//        }
//
//        titleRect.image = image
//    }
    
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
            titleLabel.leadingAnchor.constraint(equalTo: titleRect.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -3)
        ])
        
        titleRect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRect.heightAnchor.constraint(equalTo: titleRect.widthAnchor),
            titleRect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
//            titleRect.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleRect.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 3),
            titleRect.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: -15)
        ])
        
        patternView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            patternView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
        
        numberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberView.topAnchor.constraint(equalTo: patternView.topAnchor, constant: 25),
            numberView.leadingAnchor.constraint(equalTo: patternView.leadingAnchor, constant: 30),
            numberView.trailingAnchor.constraint(equalTo: patternView.trailingAnchor, constant: -35),
            numberView.bottomAnchor.constraint(equalTo: patternView.topAnchor, constant: 100)
        ])
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: numberView.centerYAnchor, constant: 2),
//            numberLabel.topAnchor.constraint(equalTo: numberView.topAnchor, constant: 10),
            numberLabel.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 15),
            numberLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -15),
//            numberLabel.bottomAnchor.constraint(equalTo: numberView.bottomAnchor, constant: 10)
        ])
    }
}



