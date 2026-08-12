//
//  ViewController.swift
//  ProyectoMoviles2
//
//  Created by DESIGN on 4/08/26.
//

import UIKit
import FirebaseAuth

class ViewController: Background {

    @IBOutlet weak var txtCorreoLogin: UITextField!
    @IBOutlet weak var txtContraLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnIngresarLogin(_ sender: UIButton) {
        let email = txtCorreoLogin.text ?? ""
        let contra = txtContraLogin.text ?? ""
        if(!email.isEmpty && !contra.isEmpty){
            Auth.auth().signIn(withEmail: email, password: contra){ [weak self] authRes, error in if let error = error {
                self?.mensaje(tit: "Error al iniciar sesion", men: error.localizedDescription)
                return
            }
                self?.performSegue(withIdentifier: "inicio", sender: nil)
            }
        }else{
            mensaje(tit: "Campos vacios" ,men: "Debe escribir correo y contraseña")
        }
    }
   
    
    @IBAction func btnRegistrarseLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "registrarUsuario", sender: nil)
    }
    
    @IBAction func btnOlvidarLogin(_ sender: UIButton) {
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier){
        case "inicio" :
            if let inicio = segue.destination as? InicioController{
                
            }
        case "registrarUsuario" :
            if let registrar = segue.destination as? RegistrarController{
                
            }
        default : break
        }
    }
}

