//
//  ManageMatchController.swift
//  Matchday
//
//  Created by Lachy Pound on 26/10/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

enum CellData {
    case playerCell(player: Player)
    case addButtonCell
}
// THIS IS NOT USED ANYMORE
class ManageMatchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // i need a delegate to send data back to the Match VC
    
    // IndexPath carrier
    var itemsToInsert = [IndexPath]()

    var playersInMatch = [[CellData]]()
    var playersInBackline = [CellData]()
    var playersInMidfield = [CellData]()
    var playersInForwardline = [CellData]()
    var playersInBench = [CellData]()
    var playerList = [CellData]()
    
    //cell IDs
    let playerID = "playerID"
    let buttonID = "buttonID"
    let headerID = "headerID"
    let cellID = "cellID"
    
    //provide a lazy var to hold data in cells
    var data = [[CellData]]()
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavElements()
        managePlayers()
        
    }
    
    //MARK:- Setup methods
    
    fileprivate func setUpNavElements() {
        navigationItem.title = "Manage Field"
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(EmptyPositionCell.self, forCellWithReuseIdentifier: buttonID)
        collectionView.register(ManagePlayerDetailView.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(MatchFieldPositionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    func managePlayers() {
        fetchPlayers()
        
        data = [
            playersInBackline,
            playersInMidfield,
            playersInForwardline,
            playersInBench,
            playerList
        ]
        
        (0 ..< data.count).forEach{
            data[$0].append(.addButtonCell)
        }
    }
    
    //MARK:- Fetch players
    
    private func fetchPlayers(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do {
            let list = try context.fetch(fetchRequest)
            list.forEach { (player) in
                self.playerList.insert(.playerCell(player: player), at: 0)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }catch let fetchError {
            print("Failed to fetch Player List with error: \(fetchError)")
        }
    }
    
    //MARK:- Collection View methods
    
//     define all the data methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch data[indexPath.section][indexPath.row] {
        case .playerCell( let player):
            // if position = listed; display in Player List
            switch player.positionOnField {
            case "Forward":
                print("Forward")
            default:
                print("Default")
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ManagePlayerDetailView
            if cell.isSelected == true {
                cell.backgroundColor = .gray
            } else {
                cell.backgroundColor = .white
            }
            cell.player = player
            return cell
        case .addButtonCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonID, for: indexPath) as! EmptyPositionCell
            return cell
        }
    }
    
    //MARK:- DidSelectitemAt IndexPath
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch data[indexPath.section][indexPath.row] {
        case .playerCell(_):
            // ensure the player is added to 'selected' array
            let cell = collectionView.cellForItem(at: indexPath)
            if cell?.isSelected == true {
                cell?.backgroundColor = .gray
            } else {
                cell?.backgroundColor = .white
            }
            itemsToInsert.append(indexPath)
            print(itemsToInsert)
        case .addButtonCell:
//            // switch the section ; change all player positions into that section
//            itemsToInsert.forEach { (index) in
//                data[index.section][index.row]
//            }
            // ensure the player 'selected' array is not empty, then add selected players to the array
            // delete the players in the old array
            print("inserting items")
            itemsToInsert.forEach { (index) in
//                let removalIndex = indexPath
//                define a new array
                var selectedPlayers = [CellData]()
                let player = data[index.section][index.row]
                selectedPlayers.append(player)
                print(selectedPlayers)
            }
            // add and insert the players to the new array
            //cleanse the array
            itemsToInsert = [IndexPath]()
        }
    }
    
    func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) ->Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        return arr
    }
    
    // SPACING OUT SELECT AND DESELECT METHODS
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch data[indexPath.section][indexPath.row] {
        case .playerCell(_):
            let cell = collectionView.cellForItem(at: indexPath)
            if cell?.isSelected == true {
                cell?.backgroundColor = .gray
            } else {
                cell?.backgroundColor = .white
            }
            // find the index
            itemsToInsert.forEach { (index) in
                if index == indexPath {
                    if let removalIndex = itemsToInsert.firstIndex(of: index) {
                        itemsToInsert.remove(at: removalIndex)
                        print("removed \(index) from \(removalIndex)")
                    }
                }
            }
            
        default:
            print("Deselected nothing.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = ((view.frame.width-3)/3)
        let benchWidthSize = ((view.frame.width-4)/4)
        let cellHeightSize: CGFloat = 42
        return indexPath.section == 4 ? CGSize(width: benchWidthSize, height: cellHeightSize) : CGSize(width: widthSize, height: cellHeightSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 42)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! MatchFieldPositionHeader
        if indexPath.section == 0 {
            header.headerTitleLabel.text = "BACKLINE"
        } else if indexPath.section == 1 {
            header.headerTitleLabel.text = "MIDFIELD"
        } else if indexPath.section == 2 {
            header.headerTitleLabel.text = "FORWARD"
        } else if indexPath.section == 3 {
            header.headerTitleLabel.text = "BENCH"
        } else {
            header.headerTitleLabel.text = "PLAYER LIST"
        }
        header.headerTitleLabel.applyHeaderStyle()
//        header.delegate = self
        return header
    }
}

//MARK:- EmptyPositionCell

class EmptyPositionCell: UICollectionViewCell {
    
    let plusText: UILabel = {
        let txt = UILabel()
        txt.textColor = .white
        txt.text = "+"
        txt.font = UIFont.boldSystemFont(ofSize: 22)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpEmptyCell()
    }
    
    func setUpEmptyCell() {
        let border = CAShapeLayer()
        border.strokeColor = UIColor.white.cgColor
        border.lineWidth = 2
        border.lineDashPattern = [6, 4]
        border.frame = CGRect(x: 0, y: 0, width: (frame.width), height: (frame.height))//self.frame
        border.fillColor = UIColor.clear.cgColor
        border.lineJoin = CAShapeLayerLineJoin.round
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: CGRect(x: 5, y: 5, width: (frame.width-10), height: (frame.height-10)), cornerRadius: 20).cgPath
        self.clipsToBounds = true
        
        self.layer.addSublayer(border)
        addSubview(plusText)
        
        NSLayoutConstraint.activate([
            plusText.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusText.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


