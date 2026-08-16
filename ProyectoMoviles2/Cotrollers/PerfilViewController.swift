//
//  PerfilViewController.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 13/08/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilViewController: BackgroundTable{

    
    @IBOutlet weak var lblNombreUsuario: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarNombre()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
            case 0:
                irDatos()
            case 1:
                misReservas()
            case 2:
                irConfiguracion()
            case 3:
                confirmarCerrarSesion()
            default:
                break
        }
    }
    
    
    
    private func cargarNombre(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        db.collection("usuario").document(uid).getDocument { [weak self] (snapshot, error) in
            if let error = error{
                self?.mensaje(tit: "Error al obtener datos", men: error.localizedDescription)
                return
            }
            if let datos = snapshot?.data(){
                let nombre = datos["nombre"] as? String ?? "Sin nombre"
                DispatchQueue.main.async {
                   self?.lblNombreUsuario.text = nombre
                }
            }
            
        }
        
    }
    
    private func irDatos(){
        performSegue(withIdentifier: "datos", sender: nil)
    }
    
    private func misReservas(){
        
    }
    
    private func irConfiguracion(){
        performSegue(withIdentifier: "configuracion", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier) {
        case "datos" :
            segue.destination as? DatosViewController
        case "configuracion":
            segue.destination as? ConfiguracionViewController
        default :
            break
        }
        
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }

}
