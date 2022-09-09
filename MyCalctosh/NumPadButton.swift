//
//  Button.swift
//  MyCalctosh
//
//  Created by Артём Харченко on 07.09.2022.
//

import UIKit

class NumPadButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        setTitle("0", for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.2
        setTitleColor(.black, for: .normal)
        titleLabel?.font =  UIFont(name: "sysfont", size: 45)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 7 , height: 7)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        
    }
    
    @objc func methods() {
        print(tag)
    }
}
