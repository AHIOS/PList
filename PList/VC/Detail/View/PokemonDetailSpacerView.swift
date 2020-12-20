//
//  PokemonDetailSpacerView.swift
//  PList
//
//  Created by Giuseppe Valenti on 20/12/20.
//

import UIKit
import PinLayout

class PokemonDetailSpacerView: UIView {
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pin.top(pin.safeArea).hCenter().width(100%).aspectRatio(1.5)
    }
    
    func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
    
}
