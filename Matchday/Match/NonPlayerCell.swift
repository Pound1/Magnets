//
//  NonPlayerCell.swift
//  Matchday
//
//  Created by Lachy Pound on 27/1/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class NonPlayerCell: BasePositionCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPositionCell()
    }
    
    let addPlayerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setImage(.add, for: .normal)
        } else {
            button.setTitle("+", for: .normal)
        }
        return button
    }()
    
    private func setUpPositionCell(){
        layer.cornerRadius = 5
        addSubview(addPlayerButton)
        let height = (frame.height)*2/3
        
        NSLayoutConstraint.activate([
            addPlayerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addPlayerButton.heightAnchor.constraint(equalToConstant: height)
        
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
