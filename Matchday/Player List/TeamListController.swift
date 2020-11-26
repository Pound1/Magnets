//
//  ViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 18/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
import CoreData

protocol TeamListControllerDelegate {
    func DidAddNewPlayer(player: Player)
    func DidEditExistingPlayer(player: Player, playerIndexPath: IndexPath)
    func checkForDuplicate(playerName: String, playerNumber: Int16) -> Bool
}

class TeamListController: UITableViewController, TeamListControllerDelegate {
        
    let cellID = "cellID"
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWelcomeCarousel()
        setUpNavElements()
        fetchPlayers()
        tableView.register(PlayerCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    func displayWelcomeCarousel() {
        //check if Carousel has been displayed
        //At first launch, display Welcome Screen
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstLaunch") == nil {
            defaults.set("No", forKey: "isFirstLaunch")
            defaults.synchronize()
            
            // display carousel
            let welcomeCarousel = CarouselTemplate()
            present(welcomeCarousel, animated: true, completion: nil)
        }
    }
    
    private func fetchPlayers(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do {
            let list = try context.fetch(fetchRequest)
            self.players = list
            self.tableView.reloadData()
        }catch let fetchError {
            print("Failed to fetch Player List with error: \(fetchError)")
        }
    }
    
    func DidAddNewPlayer(player: Player) {
        // save the new player to the player list array
        let player = player
        players.append(player)
        // adjust the tableview
        let insertionIndexPath = IndexPath(row: players.count - 1, section: 0)
        tableView.insertRows(at: [insertionIndexPath], with: .automatic)
    }
    
    func checkForDuplicate(playerName: String, playerNumber: Int16) -> Bool {
        for element in players {
            if playerName == element.name && playerNumber == element.number {
                return true
            }
            return false
        }
        return false
    }
    
    func setUpNavElements(){
        navigationItem.title = "Players"
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground // this is a medium gray (which also looks like the cell backgrounds in Settings menu)
//            view.backgroundColor = .systemBackground // this is a black (like background Settings menu)
        } else {
            view.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DisplayAddNewPlayerScreen))
        tableView.allowsMultipleSelectionDuringEditing = true
        let searchbar = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchbar
    }
    
    @objc func handleActionTap(){
        print("Tapped action btn")
    }
    
    // func to add a player to the list
    @objc func DisplayAddNewPlayerScreen(){
        print("adding player ... ")
        let addNewPlayerController = AddNewPlayerController()
        addNewPlayerController.delegate = self
        let navController = UINavigationController(rootViewController: addNewPlayerController)
        present(navController, animated: true, completion: nil)
    }
    
    func DidEditExistingPlayer(player: Player, playerIndexPath: IndexPath) {
        print("Edit existing player.. ")
        players[playerIndexPath.row] = player
        tableView.reloadRows(at: [playerIndexPath], with: .middle) //WHY: this triggers a UITableViewAlertForLayoutOutsideViewHierarchy WARNING
    }
    
    // func to delete a player from the list NO LONGER NEEDED
    func deletePlayer(cell: UITableViewCell){
        
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            players.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
}

//MARK:- tableView functions

extension TeamListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlayerCell
        
        let player = players[indexPath.row]
        
        cell.nameLabel.text = player.name
        cell.numberLabel.text = String(player.number)
        
        //this is setting the delegate, allowing the PlayerCell access to the methods in ViewController
        cell.myTableViewController = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create a viewController
        let editPlayerController = AddNewPlayerController()
        //set it's parameters i.e. player
        editPlayerController.player = players[indexPath.row]
        editPlayerController.delegate = self
        editPlayerController.playerIndexPath = indexPath

        navigationController?.pushViewController(editPlayerController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // func to delete a player
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        players.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        context.delete(player)
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save with error: \(saveErr)")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return players.isEmpty == true ? 150 : 0
    }
    
}



