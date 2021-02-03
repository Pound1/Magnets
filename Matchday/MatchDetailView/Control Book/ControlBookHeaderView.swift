//
//  ControlBookHeaderView.swift
//  Matchday
//
//  Created by Lachy Pound on 4/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class ControlBookHeaderView: UIView {
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.PaletteColour.Green.newGreen
        return image
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statistics"
        label.textColor = UIColor.PaletteColour.Green.newGreen
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        addSubview(image)
        addSubview(title)
        NSLayoutConstraint.activate([
            // left align the image
//            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
//            image.widthAnchor.constraint(equalToConstant: 30),
//            image.heightAnchor.constraint(equalToConstant: 30),
            
            // center the image
//            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: 28),
            image.heightAnchor.constraint(equalToConstant: 30),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

