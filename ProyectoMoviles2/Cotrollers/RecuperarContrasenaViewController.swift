//
//  RecuperarContrasenaViewController.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 17/08/26.
//

import UIKit
import FirebaseAuth

class RecuperarContrasenaViewController: Background {
    
    @IBOutlet weak var txtCorreo: CamposDeTexto!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnEnviar(_ sender: UIButton) {
        let cor = txtCorreo.text ?? ""
        if(cor.isEmpty){
            mensaje(tit: "Campo Vacio", men: "Ingrese un correo")
        }
        recuperarContra(correo: cor)
        
    }
    
    func recuperarContra(correo:String){
        Auth.auth().sendPasswordReset(withEmail: correo){[weak self] error in
            DispatchQueue.main.async {
                if let error = error{
                    self?.mensaje(tit: "Error al enviar correo", men: error.localizedDescription)
                }else{
                    let alerta = UIAlertController(title: "¡Éxito!", message: "Correo enviado", preferredStyle: .alert)
                        alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            if let nav = self?.navigationController {
                                nav.popViewController(animated: true)
                            } else {
                                self?.dismiss(animated: true, completion: nil)
                            }
                        }))
                        self?.present(alerta, animated: true)
                    }
                }
            }
            
        }
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }
}
    
    

