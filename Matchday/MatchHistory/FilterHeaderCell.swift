//
//  FilterHeaderCell.swift
//  Matchday
//
//  Created by Lachy Pound on 20/10/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation
import UIKit

class FilterHeaderCell: UIView {
    
    //MARK: Properties
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [filterButton, filterButton2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    let filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFilterButtonTap), for: .touchUpInside)
        return button
    }()
    let filterButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFilterButtonTap), for: .touchUpInside)
        return button
    }()
    //MARK: Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    private func SetUpHeaderCell(){
        addSubview(stackView)
        NSLayoutConstraint.activate([
//            filterButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
//            filterButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            filterButton.heightAnchor.constraint(equalToConstant: 24),
            filterButton2.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func handleFilterButtonTap() {
        print("Tapped filter")
    }
}
