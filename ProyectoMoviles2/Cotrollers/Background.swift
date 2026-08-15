//
//  Background.swift
//  ProyectoMoviles2
//
//  Created by XCODE on 10/08/26.
//

import UIKit

class Background: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageBack = UIImageView(frame: view.bounds)
        imageBack.image = UIImage(named: "hotel2")
        imageBack.contentMode = .scaleAspectFill
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        
        view.addSubview(imageBack)
        view.addSubview(blurView)
        
        view.sendSubviewToBack(blurView)
        view.sendSubviewToBack(imageBack)
    }
    

}
