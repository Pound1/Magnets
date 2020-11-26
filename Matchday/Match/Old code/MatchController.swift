//
//  MatchController.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class MatchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let matchFieldCellID = "matchFieldCellID"
    let benchFieldCellID = "benchFieldCellID"
    var players = [Player]()
    let jsonURLString = "/Users/lachypound/Library/Autosave Information/Matchday/Matchday/MockData.json"
    
    // this defines the service to use.
    var service: ServiceProtocol!
    
    override func viewDidLoad() {
        setUpCollectionView()
// this service requests the players from the server. The completion block hands back the players.
        service.fetchPlayersFromServer { (players) in
            print(players)
            // var player array set to let player array.
            self.players = players
            self.collectionView.reloadData()
        }

        collectionView.register(MatchFieldCell.self, forCellWithReuseIdentifier: matchFieldCellID)
        collectionView.register(BenchFieldCell.self, forCellWithReuseIdentifier: benchFieldCellID)
    }
    
//        let jsonURLString = "/Users/lachypound/Library/Autosave Information/Matchday/Matchday/MockData.json"
//
//        func fetchPlayingGroupData(completion: @escaping ([Player]) -> Void){
//
//            print("Attempting to fetch players...")
//
//            let url = URL(fileURLWithPath: jsonURLString)
//            URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//                if let err = err {
//                    print("Failed to download players, with error: ", err)
//                }
//
//                var players: [Player] = []
//                guard let data = data else {return}
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let jsonPlayers = try jsonDecoder.decode([JSONPlayer].self, from: data)
//                    print("Players fetched successfully.")
//                    jsonPlayers.forEach{ (jsonPlayer) in
//                        let player = Player(name: jsonPlayer.name, number: jsonPlayer.number)
//                        players.append(player)
//
//                    }
//                    DispatchQueue.main.async {
//                        completion(players)
//                    }
//                } catch let jsonDecodingError {
//                    print("Failed to decode JSON properly, with error: ", jsonDecodingError)
//                }
//                }.resume()
//        }
    
    private func setUpCollectionView(){
        navigationItem.title = "Match"
        collectionView.bounces = false
    }
}



