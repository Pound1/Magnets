//
//  MatchCell.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class MatchHistoryCell: UITableViewCell {
    
//    let matchDetails = MatchObject()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green
        label.text = "WON"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setUpCellElements()
    }
    
    private func setUpCellElements(){
        backgroundColor = provideBackgroundColour()
        imageView?.image = UIImage(imageLiteralResourceName: "shareIcon")
        imageView?.backgroundColor = .black
        
//        addSubview(resultLabel)
        NSLayoutConstraint.activate([
//            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            resultLabel.widthAnchor.constraint(equalToConstant: 60),
//            resultLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
