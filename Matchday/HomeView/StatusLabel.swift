//
//  StatusLabel.swift
//  Matchday
//
//  Created by Lachy Pound on 14/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class StatusLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        text = "Status"
        backgroundColor = UIColor.PaletteColour.Grey.midGrey
        layer.cornerRadius = 4
        layer.borderColor = UIColor.PaletteColour.Orange.orangeHighlight.cgColor
        layer.borderWidth = 2
        layer.masksToBounds = true
        font = UIFont.systemFont(ofSize: 8)
        textAlignment = .center
    }
    
    func applyColourScheme() {
        switch text {
        case matchStatus.complete.rawValue:
            backgroundColor = .clear
            layer.borderWidth = 0
            textColor = UIColor.PaletteColour.Green.darkGreen
        case matchStatus.notStarted.rawValue:
            backgroundColor = UIColor.PaletteColour.Grey.midGrey
            layer.borderColor = UIColor.PaletteColour.Orange.orangeHighlight.cgColor
            layer.borderWidth = 1
        case matchStatus.inProgress.rawValue:
            backgroundColor = UIColor.PaletteColour.Orange.orangeHighlight
            textColor = .white
            layer.borderWidth = 0
        default:
            print("Scheme couldn't be applied - unknown switch case.")
        }
    }
}
