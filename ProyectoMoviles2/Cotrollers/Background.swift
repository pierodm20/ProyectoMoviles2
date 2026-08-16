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
        
        let backContainer = UIView(frame: view.bounds)
        backContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let imageBack = UIImageView(frame: view.bounds)
        imageBack.image = UIImage(named: "hotel2")
        imageBack.contentMode = .scaleAspectFill
        imageBack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backContainer.addSubview(imageBack)
        backContainer.addSubview(blurView)
        view.addSubview(backContainer)
        view.sendSubviewToBack(backContainer)

    }
    

}
