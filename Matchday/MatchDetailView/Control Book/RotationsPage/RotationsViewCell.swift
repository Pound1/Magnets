//
//  RotationsViewCell.swift
//  Matchday
//
//  Created by Lachy Pound on 25/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class RotationsViewCell: UICollectionViewCell {
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 200/255, green: 199/255, blue: 204/255, alpha: 0.5)
        return view
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12:45"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textAlignment = .center
        return label
    }()
    let firstRotationInformation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(Player A) went from <the bench> to [forward flank]"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    let secondRotationInformation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(Player B) went from <forward flank> to [the bench]"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    private func setUpCell() {
        addSubview(timeLabel)
        addSubview(firstRotationInformation)
        addSubview(secondRotationInformation)
        addSubview(separator)
        layoutCellView()
    }
    private func layoutCellView() {
        let sectionOfWidth = frame.width/8
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: sectionOfWidth),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstRotationInformation.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            firstRotationInformation.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            firstRotationInformation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            secondRotationInformation.leadingAnchor.constraint(equalTo: firstRotationInformation.leadingAnchor),
            secondRotationInformation.topAnchor.constraint(equalTo: firstRotationInformation.bottomAnchor, constant: 2),
            secondRotationInformation.trailingAnchor.constraint(equalTo: firstRotationInformation.trailingAnchor),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
