
//
//  ViewController.swift
//  GraficasApp
//
//  Created by user240292 on 9/18/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        let controller = UIHostingController(rootView: SavingHistory())
        guard let savingsView = controller.view else {
            return
        }
        
        view.addSubview(savingsView)
        
        // Desactivar el autoresizing para usar Auto Layout manualmente
        savingsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Añadir restricciones usando Auto Layout
        NSLayoutConstraint.activate([
            // Anclar a la parte inferior de la pantalla con un espacio de 20 píxeles
            savingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            // Mantener márgenes laterales de 15 píxeles
            savingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            savingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            // Definir una altura fija para la gráfica de 300 píxeles
            savingsView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

}
