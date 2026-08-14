//
//  PerfilViewController.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 13/08/26.
//

import UIKit
import FirebaseAuth

class PerfilViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yo"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
            case 0:
                irDatos()
            case 1:
                irConfiguracion()
            case 2:
                confirmarCerrarSesion()
            default:
                break
        }
    }
    
    private func irDatos(){
        
    }
    
    private func irConfiguracion(){
        
    }
    
    private func confirmarCerrarSesion()
    {
        let alerta = UIAlertController(title: "Cerrar sesion", message: "¿Estás seguro de que deseas salir?", preferredStyle: .actionSheet)
        let btnCerrar = UIAlertAction(title: "Cerrar", style: .destructive){ [weak self] _ in
            self?.cerrarSesion()
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alerta.addAction(btnCerrar)
        alerta.addAction(btnCancelar)
        present(alerta, animated: true)
    }
    private func cerrarSesion(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let login = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? ViewController else {return}
                if let escena = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let ventana = escena.windows.first{
                    UIView.transition(with: ventana, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        ventana.rootViewController = login
                    }, completion: nil)
                }
            }
        }catch let error{
            self.mensaje(tit: "Error al cerrar sesion", men: error.localizedDescription)
        }
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }

}
