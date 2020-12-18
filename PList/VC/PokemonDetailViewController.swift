//
//  PokemonDetailViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import UIKit

class PokemonDetailViewController: UIViewController, Storyboarded {
    var pokemon: Pokemon?
    
    //Navigation
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon!.name

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
