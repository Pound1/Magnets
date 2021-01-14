//
//  File.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

// Isn't used - mark for deletion
class HomeView: UIViewController {
    
//    let matchList = [Match]
    let cellID = "cellID"
    let viewFrame = CGRect()
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("*", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryColor
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        return button
    }()
    let homeDisplayView: HomeDisplayView = {
        let view = HomeDisplayView()
        view.backgroundColor = UIColor.PaletteColour.Green.lightGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Recent","Won","Lost"])
        segment.selectedSegmentIndex = 0
        segment.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        if #available(iOS 13.0, *) {
            segment.selectedSegmentTintColor = UIColor.PaletteColour.Green.darkLeaves
        }
        segment.layer.cornerRadius = 0
        segment.backgroundColor = UIColor.PaletteColour.Green.lightGreen
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.PaletteColour.Green.lightGreen
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("+   create new match", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.PaletteColour.Green.darkLeaves
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(CreateNewMatch), for: .touchUpInside)
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        view.backgroundColor = UIColor.PaletteColour.Green.lightGreen
        setUpLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchHistoryCell.self, forCellReuseIdentifier: cellID)
    }
    
    func setUpLayout() {
        let stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [homeDisplayView, segmentedControl, tableView, newGameButton])
            stack.axis = .vertical
            stack.alignment = .center
            stack.backgroundColor = UIColor.PaletteColour.Green.lightGreen
            stack.spacing = 2
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        view.addSubview(stackView)
        view.addSubview(settingsButton)
        let viewThird = view.frame.height/3
        let tableViewWidth = view.frame.width-18
        NSLayoutConstraint.activate([
            homeDisplayView.widthAnchor.constraint(equalTo: view.widthAnchor),
            homeDisplayView.heightAnchor.constraint(equalToConstant: viewThird),
            
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            tableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            newGameButton.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            newGameButton.heightAnchor.constraint(equalToConstant: 44),
            
            settingsButton.widthAnchor.constraint(equalToConstant: 44),
            settingsButton.heightAnchor.constraint(equalToConstant: 44),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MatchHistoryCell
        cell.textLabel?.text = "cell: \(indexPath.row)"
        cell.detailTextLabel?.text = "some date"
        cell.imageView?.backgroundColor = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("taped agraldkj \(indexPath.row)")
        // create a page and display it on the nav stack
        let matchView = MatchDetailView()
        matchView.title = "Cell \(indexPath.row)"
        navigationController?.pushViewController(matchView, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Matches"
    }
}

extension HomeView {
    //MARK: ObjC methods
    @objc func openSettings() {
        print("Open settings")
        let settingsController = SettingsViewController(style: .plain)
        settingsController.title = "Settings"
        navigationController?.pushViewController(settingsController, animated: true)
    }
    @objc func CreateNewMatch() {
        print("Creating new match")
    }
}
