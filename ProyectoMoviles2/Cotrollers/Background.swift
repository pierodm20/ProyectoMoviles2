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
        imageBack.image = UIImage(named: "hotelbackground")
        imageBack.contentMode = .scaleAspectFill
        imageBack.clipsToBounds = true
        imageBack.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(imageBack, at: 0)
        
        NSLayoutConstraint.activate([
            imageBack.topAnchor.constraint(equalTo: view.topAnchor),
            imageBack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

}
