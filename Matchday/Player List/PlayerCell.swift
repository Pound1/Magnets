//
//  PlayerModel.swift
//  Matchday
//
//  Created by Lachy Pound on 18/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    // specify a property which allows us to use it's methods
    var myTableViewController: TeamListController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Player"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            label.backgroundColor = .tertiaryLabel
            label.textColor = .label
        } else {
            label.backgroundColor = UIColor.PaletteColour.Brown.bark
            label.textColor = UIColor.PaletteColour.White.marble
        }
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.text = "00"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setUpViews(){
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        addSubview(nameLabel)
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
                                     nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
                                     nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     
                                     numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
                                     numberLabel.widthAnchor.constraint(equalToConstant: 44),
                                     numberLabel.heightAnchor.constraint(equalToConstant: 44),
            ])
    }
    
    func handleDelete(){
        myTableViewController?.deletePlayer(cell: self)
    }
    
}
