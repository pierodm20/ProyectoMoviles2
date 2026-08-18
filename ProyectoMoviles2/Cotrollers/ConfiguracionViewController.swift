//
//  ConfiguracionViewController.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 16/08/26.
//

import UIKit
import FirebaseAuth

class ConfiguracionViewController: Background, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tvConfiguraciones: UITableView!
    
    @IBAction func btnAtras(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    enum TipoCelda{
        case navegacion
        case interruptor(inicial:Bool)
        case texto(valor:String)
    }
    
    struct opcionConfig{
        let icono: String
        let titulo: String
        let tipo:TipoCelda
    }
    
    private let secciones : [(titulo: String, opciones : [opcionConfig])] = [
        ("Seguridad", [
            opcionConfig(icono : "lock.fill", titulo: "Cambiar Contraseña", tipo: .navegacion)
        ]),
        ("Privacidad y Preferencias", [
            opcionConfig(icono : "eye.fill", titulo: "Perfil Publico", tipo: .interruptor(inicial: true)),
            opcionConfig(icono : "bell.fill", titulo: "Notificaciones", tipo: .interruptor(inicial: true))
        ]),
        ("Acerca de", [
            opcionConfig(icono : "info.circle.fill", titulo: "Version de App", tipo: .texto(valor: "1.0.0"))
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarNavegacion()
        configurarTabla()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configurarNavegacion() {
            title = "Configuración"
            navigationController?.navigationBar.prefersLargeTitles = false
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.tintColor = .white
        }
    
    private func configurarTabla(){
        tvConfiguraciones.delegate = self
        tvConfiguraciones.dataSource = self
        tvConfiguraciones.backgroundColor = .clear
        tvConfiguraciones.separatorColor = UIColor.white.withAlphaComponent(0.15)
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
        let celda = tvConfiguraciones.dequeueReusableCell(withIdentifier: "celdaConfig") ?? UITableViewCell(style: .value1, reuseIdentifier: "celdaConfig")
        let item = secciones[indexPath.section].opciones[indexPath.row]
        celda.textLabel?.text = item.titulo
        celda.imageView?.image = UIImage(systemName: item.icono)
        
        switch item.tipo{
        case .navegacion:
            celda.accessoryType = .disclosureIndicator
            celda.selectionStyle = .default
            celda.detailTextLabel?.text = nil
        case .interruptor(let inicial):
            let switchView = UISwitch()
            switchView.isOn = inicial
            switchView.onTintColor = .systemBlue
            celda.accessoryView = switchView
            celda.selectionStyle = .none
            celda.detailTextLabel?.text = nil
        case .texto(let valor):
            celda.accessoryType = .none
            celda.accessoryView = nil
            celda.selectionStyle = .none
            celda.detailTextLabel?.text = valor
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.textColor = UIColor.white.withAlphaComponent(0.7)
            header.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = secciones[indexPath.section].opciones[indexPath.row]
        if(item.titulo == "Cambiar Contraseña"){
            alertaEnviarCorreo()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .systemGray2
        cell.tintColor = .white
    }
    
    func alertaEnviarCorreo(){
        guard let correo = Auth.auth().currentUser?.email else{
            mensaje(tit: "Error", men: "No se encontro correo asociado")
            return
        }
        let alerta = UIAlertController(title: "Recuperar contraseña", message: "¿Deseas enviar un correo?", preferredStyle: .alert)
        let enviar = UIAlertAction(title: "Enviar", style: .default){ [weak self] _ in
            Auth.auth().sendPasswordReset(withEmail: correo){error in
                DispatchQueue.main.async {
                    if let error = error{
                        self?.mensaje(tit: "Error", men: error.localizedDescription)
                    }else{
                        self?.mensaje(tit: "!Correo enviado!", men: "Revisa tu bandeja")
                    }
                }
            }
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alerta.addAction(enviar)
        alerta.addAction(cancelar)
        
        present(alerta, animated: true)
    }
    
    func mensaje(tit:String, men:String){
        let pantalla = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        pantalla.addAction(UIAlertAction(title: "Ok", style: .default))
        present(pantalla, animated: true)
    }
}
