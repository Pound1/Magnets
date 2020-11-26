//
//  RowCell.swift
//  Matchday
//
//  Created by Lachy Pound on 24/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class RowCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        backgroundColor = .brown
        textLabel?.text = "Label"
        detailTextLabel?.text = "details"
    }
}
