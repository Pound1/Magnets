//
//  RotationHistoryView.swift
//  Matchday
//
//  Created by Lachy Pound on 25/3/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class RotationHistoryView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var matchStillRunning = false
    let cellID = "cellID"
    var delegate: MatchCollectionViewControllerDelegate?
    var rotationList = [RotationData]()
    
    let rotationTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        button.setImage(UIImage(named: "exitIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        button.setImage(UIImage(named: "shareIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.isHidden = true
        return button
    }()
    
    let clearRotationListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        button.setImage(UIImage(named: "clearIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.isHidden = true
        button.tintColor = .gray
        return button
    }()
    
    let viewTitleLabel: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Rotation History"
        title.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        title.textAlignment = .center
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForRotationData()
    }
    
    func setUpView() {
        setUpBackgroundColours()
//        shareButton.isEnabled = matchStillRunning == true ? true : false
        rotationTableView.allowsSelection = false
        rotationTableView.tableFooterView = UIView() // this removes tableView lines
        rotationTableView.delegate = self
        rotationTableView.dataSource = self
        rotationTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        view.addSubview(exitButton)
        view.addSubview(shareButton)
        view.addSubview(rotationTableView)
        view.addSubview(viewTitleLabel)
        view.addSubview(clearRotationListButton)
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 50),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            viewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            viewTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            viewTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            clearRotationListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearRotationListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            clearRotationListButton.widthAnchor.constraint(equalToConstant: 40),
            clearRotationListButton.heightAnchor.constraint(equalToConstant: 40),
            
            rotationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rotationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rotationTableView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 20),
            rotationTableView.bottomAnchor.constraint(equalTo: clearRotationListButton.topAnchor, constant: -20)
        ])
    }
    
    private func checkForRotationData() {
        if rotationList.isEmpty != true {
            shareButton.isHidden = false
            clearRotationListButton.isHidden = false
        }
    }
    
    private func fakeRotationData() {
        print("Setting fake rotation")
        let player = StubPlayer(name: "Tim", number: 11)
        let now = Date()
        let rotation1 = RotationData(player: player, position: "Wing", timeStartedOnField: now)
        rotationList.append(rotation1)
        let player2 = StubPlayer(name: "Luke", number: 2)
        let rotation2 = RotationData(player: player2, position: "Bench", timeStartedOnField: now)
        rotationList.append(rotation2)
        print(rotationList)
    }
       
    fileprivate func setUpBackgroundColours() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
            rotationTableView.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    //MARK: - Table view components
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rotationList.count
    }
    
    fileprivate func setUpCellStyle(_ cell: UITableViewCell) {
        if #available(iOS 13.0, *) {
            cell.backgroundColor = .secondarySystemBackground
            cell.textLabel?.textColor = .label
            cell.detailTextLabel?.textColor = .secondaryLabel
        } else {
            cell.backgroundColor = .white
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.alpha = 0
//
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.5 * Double(indexPath.row),
//            animations: {
//                cell.alpha = 1
//        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        //        let text = "\(rotationList[indexPath.row].player.name) rotated into \(rotationList[indexPath.row].position) position"
        setUpCellStyle(cell)
        cell.textLabel?.text = "text rotated into forward pocket position"
        cell.detailTextLabel?.text = "15s ago"
        let name = rotationList[indexPath.row].player.name
        let position = rotationList[indexPath.row].position
        cell.textLabel?.text = "\(name ?? "Player") rotated out of \(position) position"
//        let timeString = String(rotationList[indexPath.row].timeIntervalSinceStartingOnField)
        let now = Date()
        let startingTime = rotationList[indexPath.row].timeStartedOnField
        print("Starting time: ")
        print(rotationList[indexPath.row].timeStartedOnField)
        var timeInt = Int(now.timeIntervalSince(startingTime))
        timeInt = timeInt - rotationList[indexPath.row].timeIntervalSinceStartingOnField
        let timeInterval = timeIntervalDisplay(timeInterval: timeInt)
        cell.detailTextLabel?.text = timeInterval
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    // MARK: - @objc functions
    
    @objc func handleExit(){
        delegate?.removeView(view: self)
    }
    
    @objc func handleShare() {
        if matchStillRunning == true {
            let alert = UIAlertController(title: "Reset Match Timer", message: "The match is in progress. To share rotation data first reset the timer on the Match screen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true) {
                self.delegate?.handleSendRotationData()
            }
        }
    }
    
    @objc func handleClear() {
        print("Clearing...")
        if matchStillRunning == true {
            // Request the user stop the game timer.
            let alert = UIAlertController(title: "Reset Match Timer", message: "The match is in progress. To clear rotation data first reset the timer on the Match screen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // handle delete
            let alert = UIAlertController(title: "Clear Rotation History?", message: "Once cleared, the history will no longer be available. Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { (_) in
                self.rotationList.removeAll() // need to send this back to the list
                self.rotationTableView.reloadData()
                self.clearRotationListButton.isHidden = true
                self.shareButton.isHidden = true
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    // MARK: - private functions
    func timeIntervalDisplay(timeInterval: Int) -> String {
        
        let minute = 60
        let hour = 60 * minute
        
        if timeInterval < 2 {
            return "1 second ago"
        } else if timeInterval < minute {
            return "\(timeInterval) seconds ago"
        } else if timeInterval < hour {
            if timeInterval < 119 {
                return "1 minute ago"
            }
            return "\(timeInterval / minute) minutes ago"
        }
        return "\(timeInterval / hour) hour(s) ago"
    }
    
    // MARK: - "No rotations available" Prompt
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        footer.footerTitle.text = "Rotation data will appear here."
        footer.footerTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        footer.footerSubText.text = "Swap players to create rotations. Rotations will only be recorded when the game clock is on."
        footer.footerSubText.font = UIFont.italicSystemFont(ofSize: 14)
        footer.footerSubText.numberOfLines = 4
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return rotationList.isEmpty == true ? 150 : 0
    }
}
