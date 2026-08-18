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
                self?.irAlInicio()
            }
        }else{
            mensaje(tit: "Campos vacios" ,men: "Debe escribir correo y contraseña")
        }
    }
   
    
    @IBAction func btnRegistrarseLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "registrarUsuario", sender: nil)
    }
    
    @IBAction func btnOlvidarLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "recuperarContra", sender: nil)
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier){
        case "inicio" :
            segue.destination as? InicioController
        case "registrarUsuario" :
            segue.destination as? RegistrarController
        case "recuperarContra":
            segue.destination as?  RecuperarContrasenaViewController
        default : break
        }
    }
    
    func irAlInicio(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
            let nav = UINavigationController(rootViewController: tabBar)
            
            if let escena = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let ventana = escena.windows.first{
                UIView.transition(with: ventana, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    ventana.rootViewController = nav
                }, completion: nil)
            }
        }
    }
}

