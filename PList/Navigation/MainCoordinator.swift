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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail(itemID: Int) {
        let vc = PokemonDetailViewController.instantiate()
        vc.pokemonId = itemID
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
