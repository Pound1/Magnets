//
//  StatIncrementerView.swift
//  Matchday
//
//  Created by Lachy Pound on 25/2/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class StatIncrementerView: UIView {
    var delegate: IncrementAndDecrementDelegate?
    var type: statisticType?
    var statValue = 0 {
        didSet {
            statLabel.text = String(statValue)
        }
    }
    var statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.addTarget(self, action: #selector(incrementStatCount), for: .touchUpInside)
        return button
    }()
    let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.addTarget(self, action: #selector(decrementStatCount), for: .touchUpInside)
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, statLabel, plusButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    func setUpView() {
        addSubview(minusButton)
        addSubview(statLabel)
        addSubview(plusButton)
        NSLayoutConstraint.activate([

            plusButton.heightAnchor.constraint(equalToConstant: 20),
            plusButton.widthAnchor.constraint(equalToConstant: 20),

            minusButton.heightAnchor.constraint(equalToConstant: 20),
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            
            statLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            minusButton.trailingAnchor.constraint(equalTo: statLabel.leadingAnchor, constant: -2),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: statLabel.trailingAnchor, constant: 2),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    @objc func decrementStatCount(){
        if statValue > 0 {
            guard let type = type else {return}
            delegate?.decrement(type: type)
        } else {
            print("Could not go less than zero")
        }
    }
    
    @objc private func incrementStatCount() {
        guard let type = type else {return}
        delegate?.increment(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
