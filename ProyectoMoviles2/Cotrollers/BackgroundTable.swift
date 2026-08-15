//
//  BackgroundTable.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 14/08/26.
//

import UIKit

class BackgroundTable: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fondoBorroso()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            configurarTabBarTransparente()
        }

    private func fondoBorroso(){
        let imageBack = UIImageView(frame: view.bounds)
        imageBack.image = UIImage(named: "hotel2")
        imageBack.contentMode = .scaleAspectFill
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        
        let backContainer = UIView(frame: view.bounds)
        backContainer.addSubview(imageBack)
        backContainer.addSubview(blurView)
        
        tableView.backgroundView = backContainer
        tableView.backgroundColor = .clear
    }
    
    private func configurarTabBarTransparente() {
        guard let tabBar = tabBarController?.tabBar else { return }
            
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            tabBar.tintColor = .white
            tabBar.unselectedItemTintColor = .systemGray2

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        cell.backgroundColor = .clear
    }

}
