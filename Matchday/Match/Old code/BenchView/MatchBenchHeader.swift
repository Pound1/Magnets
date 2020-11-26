//
//  MatchBenchHeader.swift
//  Matchday
//
//  Created by Lachy Pound on 6/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class MatchBenchHeader: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchBenchHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerTitleLabel: UILabel = {
        let label = UILabel()
        let headerText = "Header"
        label.text = headerText.uppercased()
        label.addCharacterSpacing()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpMatchBenchHeader(){
        addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
