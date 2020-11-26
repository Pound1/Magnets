//
//  MatchTableViewHeaderCell.swift
//  Matchday
//
//  Created by Lachy Pound on 25/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

// currently not used. Tossing up between presenting a cell or a view..
class MatchTableViewHeaderView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = label.provideSecondaryLabelColour()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = provideSecondaryBackgroundColour()
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
