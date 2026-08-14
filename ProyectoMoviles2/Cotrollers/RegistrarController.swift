
import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegistrarController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var txtnNombreReg: UITextField!
    @IBOutlet weak var txtApellidoReg: UITextField!
    @IBOutlet weak var txtCorreoReg: UITextField!
    @IBOutlet weak var txtTelefonoReg: UITextField!
    @IBOutlet weak var txtContraseñaReg: UITextField!
    @IBOutlet weak var txtRepetirReg: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtTelefonoReg.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == txtTelefonoReg {
                // Permitir borrar caracteres (string vacío) o verificar si los nuevos caracteres son solo números
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
            return true
        }
    
    @IBAction func btnRegistrarReg(_ sender: UIButton) {
        let nom = txtnNombreReg.text ?? ""
        let ape = txtApellidoReg.text ?? ""
        let correo = txtCorreoReg.text ?? ""
        let tef = txtTelefonoReg.text ?? ""
        let contra = txtContraseñaReg.text ?? ""
        let rep = txtRepetirReg.text ?? ""
        
        guard (!nom.isEmpty && !ape.isEmpty && !correo.isEmpty && !tef.isEmpty && !contra.isEmpty && !rep.isEmpty) else{
            mensaje(tit: "Campos vacios", men: "Llenar todos los campos")
            return
        }
        
        if(tef.count < 9){
            mensaje(tit: "Telefono invalido", men: "El telefono tiene que tener mas de 9 digitos")
            return
        }
        
        if (contra.count < 6) {
            mensaje(tit: "Contraseña corta", men: "La contraseña debe tener al menos 6 caracteres.")
            return
        }
        
        if(contra != rep){
            mensaje(tit: "Contraseñas no coinciden", men: "Las contraseñas tienen que ser iguales")
            return
        }
        
        Auth.auth().createUser(withEmail: correo, password: contra){ [weak self] authResult, error in
            if let error = error {
                self?.mensaje(tit: "Error de registro", men: error.localizedDescription)
                return
            }
            
            guard let uid = authResult?.user.uid else {return}
            let usuario: [String: Any] = [
                "uid" : uid,
                "nombre" : nom,
                "apellido" : ape,
                "correo" : correo,
                "telefono" : tef,
                "fechaCreacion" : Date()
            ]
            
            self?.db.collection("usuario").document(uid).setData(usuario) { error in
                if let error = error {
                    self?.mensaje(tit: "Error al guardar perfil", men: error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                    let alerta = UIAlertController(title: "¡Éxito!", message: "Usuario registrado correctamente", preferredStyle: .alert)
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
    }
        
    func mensaje(tit:String, men:String){
        DispatchQueue.main.async { [weak self] in
            let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
            pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(pantalla, animated: true)
        }
    }
    
}
