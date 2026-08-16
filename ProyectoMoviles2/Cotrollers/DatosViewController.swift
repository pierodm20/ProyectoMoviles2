

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DatosViewController: Background, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tvDatos: UITableView!
    private let db = Firestore.firestore()
    private var secciones : [(titulo: String, opciones: [(icono: String, campo: String, valor:String)])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarNavegacion()
        configurarTabla()
        obtenerDatos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnAtras(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    private func obtenerDatos(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        db.collection("usuario").document(uid).addSnapshotListener{
            [weak self] snapshot, error in
                guard let self = self else {return}
            if let error = error{
                mensaje(tit: "Error", men: error.localizedDescription)
                return
            }
            guard let data = snapshot?.data() else {
                mensaje(tit: "Error", men: "El documento del usuario no existe")
                return
            }
            let nom = data["nombre"] as? String ?? "SIN NOMBRE"
            let ape = data["apellido"] as? String ?? "SIN APELLIDO"
            let nomCompleto = "\(nom) \(ape)".trimmingCharacters(in: .whitespaces)
            let correo = Auth.auth().currentUser?.email ?? (data["correo"] as? String ?? "SIN CORREO")
            let tef = data["telefono"] as? String ?? "NO REGISTRADO"
            let dni = data["dni"] as? String ?? "NO REGISTRADO"
            
            DispatchQueue.main.async {
                self.secciones = [
                    ("Informacion Personal", [(
                        "person.fill", "Nombre", nomCompleto
                    ),("envelope.fill", "Correo", correo),
                    ("phone.fill", "Teléfono", tef)
                    ]),
                    ("Seguridad y cuenta", [(
                        "doc.text.fill",  "Documento", "DNI - \(dni)"),
                    ("lock.fill", "Contraseña", "••••••••••")
                    ])
                ]
                self.tvDatos.reloadData()
            }
        }
    }
    
    private func configurarNavegacion() {
        title = "Mis Datos"
            
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configurarTabla(){
        tvDatos.delegate = self
        tvDatos.dataSource = self
        tvDatos.backgroundColor = .clear
        tvDatos.separatorColor = UIColor.white.withAlphaComponent(0.15)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return secciones.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secciones[section].opciones.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section].titulo
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tvDatos.dequeueReusableCell(withIdentifier: "celdaDato") ?? UITableViewCell(style: .value1, reuseIdentifier: "celdaDato")
        let item = secciones[indexPath.section].opciones[indexPath.row]
        celda.textLabel?.text = item.campo
        celda.detailTextLabel?.text = item.valor
        celda.imageView?.image = UIImage(systemName: item.icono)
        celda.selectionStyle = .none
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.textColor = UIColor.white.withAlphaComponent(0.7)
            header.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textColor = .systemGray2
        cell.detailTextLabel?.textColor = .white
        cell.tintColor = .white
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }

}
