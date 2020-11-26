//
//  MatchTimerView.swift
//  Matchday
//
//  Created by Lachy Pound on 15/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class MatchTimerView: UIView {
    
    var matchCollectionViewDelegate: MatchCollectionViewControllerDelegate?
    
    var timeStarted = false
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00:00.0"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var refreshTimerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "refreshIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleRefreshTimer), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "recordIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePlayAndPauseButton), for: .touchUpInside)
        return button
    }()
    
    lazy var sendDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "historyIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSendData), for: .touchUpInside)
        return button
    }()
    
    let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let recordingImageView: UIImageView = { // not used.
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(imageLiteralResourceName: "recordingIcon").withRenderingMode(.alwaysTemplate)
        image.isHidden = true
        image.tintColor = .white
        return image
    }()
    
    let recordingLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchTimerElements()
    }
    
    private func setUpMatchTimerElements() {
        backgroundColor = UIColor.PaletteColour.BlueGray.secondaryColor
        translatesAutoresizingMaskIntoConstraints = false
        
        
        menuStackView.addArrangedSubview(sendDataButton)
        menuStackView.addArrangedSubview(refreshTimerButton)
        menuStackView.addArrangedSubview(playButton)
        menuStackView.addArrangedSubview(timerLabel)

        addSubview(menuStackView)
        addSubview(recordingLabel)
        NSLayoutConstraint.activate([
            timerLabel.widthAnchor.constraint(equalToConstant: 120),
            
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            menuStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            recordingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            recordingLabel.centerXAnchor.constraint(equalTo: timerLabel.centerXAnchor, constant: -4)
            ])
    }
    
    @objc private func handlePlayAndPauseButton() {
        
        if timeStarted == false {
            handlePlayButton()
            timeStarted = true
            playButton.setImage(UIImage(named: "recordingIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            handlePauseButton()
            timeStarted = false
            playButton.setImage(UIImage(named: "recordIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @objc private func handleSendData() {
        print("Tapped send data button.")
        matchCollectionViewDelegate?.displayRotationHistory()
    }
    
    @objc func handleRefreshTimer(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.refreshTimerButton.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn, animations: {
            self.refreshTimerButton.alpha = 1
        }, completion: nil)
        if timerLabel.text != "0:00:00.0" {
            // refresh the timer
            self.recordingLabel.isHidden = true
            self.matchCollectionViewDelegate?.checkIfUserWantedToResetTimer()
        }
    }
    
    func handlePlayButton(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.playButton.alpha = 0
        }, completion: nil)
        self.matchCollectionViewDelegate?.handleStartMatchTimer()
        self.refreshTimerButton.isEnabled = true
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            self.playButton.alpha = 1
        }, completion: nil)
        recordingLabel.isHidden = false
        recordingLabel.text = "Recording"
    }
    func handlePauseButton(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.playButton.alpha = 0
        }, completion: nil)
        self.matchCollectionViewDelegate?.handlePauseMatchTimer()
        self.recordingLabel.text = "Recording paused"
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            self.playButton.alpha = 1
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
