//
//  ResultView.swift
//  Matchday
//
//  Created by Lachy Pound on 24/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class MatchInfoView: UIView {
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [matchResult, teamScore, opponentScore, gameLength, totalRotations, datePlayed])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = stack.provideBackgroundColour()
        return stack
    }()
    let matchResult: UILabel = {
        let label = UILabel()
        label.text = "WON"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let teamScore: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Glen Eira"
        view.valueLabel.text = "7.12(54)"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let opponentScore: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Opponent"
        view.valueLabel.text = "5.9(39)"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let gameLength: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Total Game Time"
        view.valueLabel.text = "2:15:12"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let totalRotations: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Total Rotations"
        view.valueLabel.text = "47"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let datePlayed: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Date Played"
        view.valueLabel.text = "12 Oct 2020"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    private func setUpView() {
        backgroundColor = provideBackgroundColour()
        addViews()
    }
    private func addViews() {
        addSubview(stackView)
        layoutViews()
    }
    private func layoutViews() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// This is the detailed subview which is reproduced to list out the data for the Match result.
class CustomMatchDetailView: UIView {
    
    var fontSize = 12
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let detailLabel: UILabel = {
       let label = UILabel()
        label.text = "the opponent score"
        label.textAlignment = .left
        label.textColor = label.provideSecondaryLabelColour()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let valueLabel: UILabel = {
       let label = UILabel()
        label.text = "16.8.104"
        label.textAlignment = .right
        label.textColor = label.provideSecondaryLabelColour()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCustomView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func adjustFontSize(size: CGFloat){
        detailLabel.font = UIFont.boldSystemFont(ofSize: size)
        valueLabel.font = UIFont.systemFont(ofSize: size)
    }
    
    private func setUpCustomView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
