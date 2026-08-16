//
//  CamposDeTexto.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 12/08/26.
//

import UIKit

class CamposDeTexto: UITextField {
    private let input = CALayer()

        override func awakeFromNib() {
            super.awakeFromNib()
            configurarEstilo()
        }

        private func configurarEstilo() {
            self.borderStyle = .none
            self.backgroundColor = .clear
            self.textColor = .label
            if let place = self.placeholder{
                self.attributedPlaceholder = NSAttributedString(string: place, attributes: [.foregroundColor: UIColor.systemGray])
            }
            
            input.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
            layer.addSublayer(input)
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        input.frame = CGRect(
            x:0,
            y:self.frame.height - 1.5,
            width: self.frame.width,
            height: 1.5
        )
        
    }
       
}
