//
//  CamposDeTexto.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 12/08/26.
//

import UIKit

class CamposDeTexto: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

        override func awakeFromNib() {
            super.awakeFromNib()
            configurarEstilo()
        }

        private func configurarEstilo() {
            // 2. Aquí aplicas tu redondeo personalizado
            self.layer.cornerRadius = 10 // Cambia el radio según tu diseño
            self.layer.masksToBounds = true
            
            // Si le agregas bordes personalizados:
            // self.layer.borderWidth = 1
            // self.layer.borderColor = UIColor.systemBlue.cgColor
        }

        // 3. Sobrescribir los rectángulos donde se dibuja el texto
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}
