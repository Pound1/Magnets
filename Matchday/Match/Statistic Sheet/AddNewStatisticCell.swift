//
//  AddNewStatisticCell.swift
//  Matchday
//
//  Created by Lachy Pound on 6/6/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class AddNewStatisticCell: UITableViewCell {
    
    var delegate: TeamSheetControllerDelegate?
    
    let addNewStatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        if #available(iOS 13.0, *) {
            button.titleLabel?.textColor = .label
            button.setTitleColor(.systemGray, for: .normal)
        } else {
            button.setTitleColor(.black, for: .normal)
        }
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpCellElements()
    }
    
    private func setUpCellElements(){
        addSubview(addNewStatButton)
        NSLayoutConstraint.activate([
        addNewStatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        addNewStatButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        addNewStatButton.widthAnchor.constraint(equalToConstant: 44),
        addNewStatButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
