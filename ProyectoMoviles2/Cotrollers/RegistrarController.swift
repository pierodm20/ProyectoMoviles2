
import UIKit
import FirebaseFirestore

class RegistrarController: UIViewController {
   
    @IBOutlet weak var txtnNombreReg: UITextField!
    @IBOutlet weak var txtApellidoReg: UITextField!
    @IBOutlet weak var txtCorreoReg: UITextField!
    @IBOutlet weak var txtTelefonoReg: UITextField!
    @IBOutlet weak var txtContraseñaReg: UITextField!
    @IBOutlet weak var txtRepetirReg: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegistrarReg(_ sender: UIButton) {
        let nom = txtnNombreReg.text ?? ""
        let ape = txtApellidoReg.text ?? ""
        let correo = txtCorreoReg.text ?? ""
        let tef = txtTelefonoReg.text ?? ""
        let contra = txtContraseñaReg.text ?? ""
        let rep = txtRepetirReg.text ?? ""
    }
    
}
