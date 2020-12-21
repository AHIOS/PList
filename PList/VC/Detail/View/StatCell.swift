//
//  StatCell.swift
//  PList
//
//  Created by Giuseppe Valenti on 21/12/20.
//

import UIKit
import PinLayout

class StatCell: UITableViewCell {
    static let reuseIdentifier = "MethodCell"
    
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    private let progress = ProgressBar()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        nameLabel.text = "ATTACK"
        nameLabel.textAlignment = .right
        nameLabel.sizeToFit()
        
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(valueLabel)
        valueLabel.text = " 75 "
        valueLabel.sizeToFit()
        
//        progress.progress = 0.75
        progress.backgroundColor = .systemGray
        contentView.addSubview(progress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(stat: Stat) {
        nameLabel.text = stat.name
        valueLabel.text = String(stat.value)
        nameLabel.sizeToFit()
        valueLabel.sizeToFit()
        let percentage = CGFloat(stat.value)/120
        progress.color = UIColor.red.toColor(.green, percentage: CGFloat(stat.value))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progress.progress = percentage
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        valueLabel.pin.marginHorizontal(5).right(10).vCenter().width(25)
        progress.pin.before(of: valueLabel, aligned: .center).marginHorizontal(5).width(55%).height(30%)
        nameLabel.pin.before(of: progress).marginHorizontal(5).left(10).vCenter()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
