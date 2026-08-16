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
        imageBack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let backContainer = UIView(frame: view.bounds)
        backContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
            appearance.backgroundEffect = UIBlurEffect(style: .regular)

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .systemGray2
        }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.tintColor = .systemGray4
    }

}
