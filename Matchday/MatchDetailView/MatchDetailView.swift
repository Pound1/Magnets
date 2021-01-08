//
//  MatchView.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class MatchDetailView: UIViewController  {
    
    
    //MARK: Properties
    let cellID = "cellID"
    let headerCell = "headerCell"
    let listCell = "listCell"
    let tableViewHeader = "tableViewHeader"
    
    let whiteBackdropForCustomTabBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let controlBook = ControlBookViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PaletteColour.Green.newGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let selectedCell = 0
    let informationView: MatchDetailInformationView = {
        let view = MatchDetailInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.headerReferenceSize = CGSize(width: 100, height: 68)
        layout.itemSize = CGSize(width: 10, height: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    //MARK: Setup methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    func setUpView() {
        view.backgroundColor = UIColor.PaletteColour.Green.newGreen
        navigationController?.isNavigationBarHidden = false
        setUpInformationView()
        setUpCollectionView()
        setUpControlBook()
//        setUpTableView()
        activateConstraints()
    }
    private func setUpControlBook() {
        addChild(controlBook)
        view.addSubview(controlBook.view)
        controlBook.didMove(toParent: self)
        controlBook.view.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func setUpInformationView() {
        view.addSubview(informationView)
        view.addSubview(seperatorView)
        view.addSubview(whiteBackdropForCustomTabBar)
    }
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.isScrollEnabled = true
        collectionView.register(QuarterCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.register(RowCell.self, forCellReuseIdentifier: listCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewHeader)
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func activateConstraints() {
//        let definedThird = view.frame.height/3
        NSLayoutConstraint.activate([
            
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationView.topAnchor.constraint(equalTo: view.topAnchor),
            informationView.heightAnchor.constraint(equalToConstant: 100),
            
            seperatorView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: informationView.trailingAnchor),
            seperatorView.topAnchor.constraint(equalTo: informationView.topAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            controlBook.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlBook.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlBook.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            controlBook.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            whiteBackdropForCustomTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBackdropForCustomTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBackdropForCustomTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteBackdropForCustomTabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
//MARK: Tableview Methods
extension MatchDetailView: UITableViewDelegate {
    
}

extension MatchDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCell, for: indexPath) as! RowCell
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MatchTableViewHeaderView()
        return header
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "data"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
}

//MARK: CollectionView methods
extension MatchDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! QuarterCell
        let quarterNumber = indexPath.row + 1
        cell.cellTitle.text = "Q\(quarterNumber)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? QuarterCell {
            cell.showSelectedCell()
        }
        if indexPath.row != 0 { // this removes the highlight on the auto-selected cell when the view loads.
            let index = IndexPath(row: 0, section: 0)
            if let cell = collectionView.cellForItem(at: index) as? QuarterCell {
                cell.hideSelectedCell()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? QuarterCell {
            cell.hideSelectedCell()
        }
    }
}

extension MatchDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthOfView = view.frame.width
        let widthOfTile = (widthOfView-50)/4
        return CGSize(width: widthOfTile, height: widthOfTile)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let customInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return customInsets
    }
}

extension MatchDetailView: UICollectionViewDelegate {
    
}


