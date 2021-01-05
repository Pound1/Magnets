//
//  StatisticHeaderViewCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class StatisticHeaderViewCell: UIView {
    let statisticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STATISTIC"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    let homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HOME"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    let awayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AWAY"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [homeLabel, awayLabel])
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
        addSubview(statisticLabel)
        addSubview(stackView)
        layoutView()
    }
    func layoutView() {
        let centerOfView = centerXAnchor
        NSLayoutConstraint.activate([
            statisticLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statisticLabel.trailingAnchor.constraint(equalTo: centerOfView),
            statisticLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            stackView.topAnchor.constraint(equalTo: statisticLabel.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: centerOfView),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: statisticLabel.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
