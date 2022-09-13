//
//  Button.swift
//  Calcintosh
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
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
            layer.borderColor = isHighlighted ? UIColor.white.cgColor : UIColor.black.cgColor
        }
    }
    
    func setButton() {
        titleLabel?.font = UIFont(name: "sysfont", size: 50)
        
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .highlighted)
        
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 7 , height: 7)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
    }
}
