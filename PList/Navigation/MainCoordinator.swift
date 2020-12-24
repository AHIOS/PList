//
//  MainCoordinator.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = PokemonTableViewController.instantiate()
//        let vc = PokeDeckViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
//        tableCollectionSwitch()
    }
    
    func showDetail(itemID: Int) {
        let vc = PokemonDetailViewController.instantiate()
        vc.pokemonId = itemID
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
//    func tableCollectionSwitch() {
//        let image = UIImage(systemName: "list.bullet")
//        let rightButton = UIBarButtonItem(title:"switch", style: .plain, target: self, action: #selector(switchView))
//        self.navigationController.navigationItem.rightBarButtonItem = rightButton
//    }
//
//    @objc func switchView() {
//        if (UserDefaults.standard.object(forKey: "grid") as? String != nil) {
//            UserDefaults.standard.set("grid", forKey: "grid")
//        }
//    }
}
