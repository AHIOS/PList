//
//  StatsView.swift
//  PList
//
//  Created by Giuseppe Valenti on 21/12/20.
//

import UIKit

class StatsView: UIView {

    let tableView = UITableView()
    private let methodCellTemplate = StatCell()
    
    private var stats: [Stat] = []
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        tableView.estimatedRowHeight = 10
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(StatCell.self, forCellReuseIdentifier: StatCell.reuseIdentifier)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(stats: [Stat]) {
        self.stats = stats
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension StatsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatCell.reuseIdentifier, for: indexPath) as! StatCell
        cell.configure(stat: stats[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
        return UITableView.automaticDimension
    }
    
}

