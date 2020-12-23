//
//  PokemonDetailView.swift
//  PList
//
//  Created by Giuseppe Valenti on 20/12/20.
//

import UIKit
import PinLayout

class PokemonDetailView: UIView {
    private let spacerView = PokemonDetailSpacerView()
    private let headerView = PokemonDetailHeaderView()
    private let statsView = StatsView()
    private let roundedView = UIView()
    var imageView = UIImageView()

    init(){
        super.init(frame: .zero)
        addSubview(spacerView)
        addSubview(headerView)
        addSubview(roundedView)
        addSubview(imageView)
        addSubview(statsView)
        roundedView.roundCorners([.topLeft, .topRight], radius: 15)
        self.pin.all()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spacerView.pin.top(pin.safeArea).hCenter().width(100%).aspectRatio(1.5)
        headerView.pin.below(of: spacerView, aligned: .center).height(10%).width(of:spacerView)
        roundedView.pin.bottomCenter(to:spacerView.anchor.bottomCenter).width(of:spacerView).height(30).width(of:spacerView)
        imageView.pin.bottomCenter(to:spacerView.anchor.bottomCenter).width(200).height(200)
        statsView.pin.below(of: headerView, aligned: .center).bottom().width(of:spacerView)
    }
    
    func setPrimaryColor(color:UIColor){
        spacerView.setBackground(color: color)
        headerView.primaryColor = color
        roundedView.backgroundColor = headerView.backgroundColor
        roundedView.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    func set(name:String){
        headerView.set(name:name)
    }
    
    func set(type:String){
        headerView.set(type:type)
    }
    
    func set(image:UIImage){
        imageView.image = image
    }
    
    func set(stats:[Stat]){
        statsView.configure(stats: stats)
    }
}
