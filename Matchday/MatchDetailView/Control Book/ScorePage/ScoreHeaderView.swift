//
//  ScoreHeaderView.swift
//  Matchday
//
//  Created by Lachy Pound on 23/2/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class ScoreHeaderView: UIView {
    let scoreImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "goal_posts").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let goalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Goals"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Points"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [goalLabel, pointLabel, totalLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = provideBackgroundColour()
        setUpView()
    }
    func setUpView() {
        addSubview(scoreImage)
        addSubview(stackView)
        layoutView()
    }
    func layoutView() {
        let centerOfView = centerXAnchor
        NSLayoutConstraint.activate([
            scoreImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            scoreImage.trailingAnchor.constraint(equalTo: centerOfView),
            scoreImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            scoreImage.heightAnchor.constraint(equalToConstant: 30),
            scoreImage.widthAnchor.constraint(equalToConstant: 28),
            
            
            stackView.topAnchor.constraint(equalTo: scoreImage.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: centerOfView),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scoreImage.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
