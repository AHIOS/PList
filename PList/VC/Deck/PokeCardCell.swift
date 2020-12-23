//
//  PokeCardCell.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import UIKit
import PinLayout

class PokeCardCell: UICollectionViewCell {
    static let reuseIdentifier = "PokeCardCell"
    
    private let nameLabel = UILabel()
    private let mainImage = UIImageView()
    private let typeLabel = UILabel()
    private var primaryColor = UIColor()
    
    let hardcodedtype = "grass"
    
    private let margin: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        primaryColor = .orange

        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .systemBackground
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(nameLabel)
        
        mainImage.backgroundColor = .clear
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        contentView.addSubview(mainImage)
        
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        typeLabel.textColor = .systemBackground
        contentView.addSubview(typeLabel)
        
        self.layer.cornerRadius = margin
        self.clipsToBounds = true
        
        if (traitCollection.userInterfaceStyle == .light){
            typeLabel.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.25)
        }else{
            typeLabel.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.15)
        }
        
    
        
        //Todo:  ADD shadow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(poke: Poke) {
        nameLabel.text = poke.name
        nameLabel.sizeToFit()
        DataRetriever.getImageDataForItem(id: poke.id) { [self] data in
            mainImage.image = UIImage(data: data!)
        }
        mainImage.contentMode = .scaleAspectFill
        mainImage.backgroundColor = .clear
        
        typeLabel.text = " \(hardcodedtype) "
        typeLabel.layer.cornerRadius = typeLabel.frame.size.height/2
        typeLabel.sizeToFit()
        typeLabel.clipsToBounds = true
        
        primaryColor = .orange
        backgroundColor = primaryColor
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        mainImage.pin.bottomRight(4).height(60).aspectRatio()
        typeLabel.pin.left(margin).bottom(20)
        nameLabel.pin.topLeft(margin).right()
        nameLabel.sizeToFit()
        
        contentView.pin.height(120)
        
        typeLabel.layer.cornerRadius = typeLabel.frame.size.height/2
        typeLabel.clipsToBounds = true
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}

