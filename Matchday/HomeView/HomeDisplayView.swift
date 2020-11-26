//
//  HomeDisplayView.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class HomeDisplayView: UIView {
    // I want a textField in the middle
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.PaletteColour.Green.lightGreen
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 10
        image.layer.shouldRasterize = true
        image.layer.cornerRadius = 10
//        image.clipsToBounds = true
        return image
    }()
    let titleText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Boardman"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        return title
    }()
    // set background to be sure it works
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpDisplay()
    }
    
    func setUpDisplay() {
        backgroundColor = .yellow
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(titleText)
        addSubview(logoImage)
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.bottomAnchor.constraint(equalTo: titleText.topAnchor, constant: -12),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
