//
//  Service.swift
//  Matchday
//
//  Created by Lachy Pound on 8/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func fetchPlayersFromServer(completion: @escaping ([Player]) -> Void)
}

class Service: ServiceProtocol {
    
    // creating a singleton will be my main source of truth.
    static var shared = Service()
    let jsonURLString = "/Users/lachypound/Library/Autosave Information/Matchday/Matchday/MockData.json"
    
    func fetchPlayersFromServer(completion: @escaping ([Player]) -> Void){
        
        print("Attempting to fetch players...")
        
        // MARK: - The url fails on a device. Is this because the MockData.json is not being included in the app build?
        let url = URL(fileURLWithPath: jsonURLString)
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to download players, with error: ", err)
            }
            let players: [Player] = []

            // ACTIVATE THE BELOW IF SERVICE BEING USED
//            var players: [Player] = []
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let jsonPlayers = try jsonDecoder.decode([JSONPlayer].self, from: data)
                print("Players fetched successfully.")
                jsonPlayers.forEach{ (jsonPlayer) in
//                    let player = Player(name: jsonPlayer.name, number: jsonPlayer.number, position: jsonPlayer.position)
                    // NEW
                    
                    //MARK:- THIS NEEDS TO BE FIXED FOR SERVICE TO FUNCTION
//                    let player = Player(name: jsonPlayer.name, number: jsonPlayer.number)
//                    players.append(player)
                }
                DispatchQueue.main.async {
                    completion(players)
                }
            } catch let jsonDecodingError {
                print("Failed to decode JSON properly, with error: ", jsonDecodingError)
            }
        }.resume()
    }
    
//    func getPlayersObtainedFromServer() -> [Player]{
//        print(players)
//        return players
//    }
}

struct JSONPlayer: Decodable {
    
    let name: String
    let number: Int
    let position: PositionOnField

    init(name: String, number: Int, position: PositionOnField) {
        self.name = name
        self.number = number
        self.position = position
    }
}

//class MockService: ServiceProtocol {
    //MARK:- THIS NEEDS TO BE ENABLED FOR MOCK SERVICE TO FUNCTION:
//    func fetchPlayersFromServer(completion: @escaping ([Player]) -> Void) {
//
//        completion([
//            Player(name: "JB", number: 01),
//            Player(name: "Julius Waras-Carstensen", number: 02),
//            Player(name: "J Ludik", number: 03),
//            Player(name: "Smout", number: 04),
//            Player(name: "Kye Cherian", number: 05),
//            Player(name: "P Falvo", number: 06),
//            Player(name: "Chad Kadish", number: 07),
//            Player(name: "Richo", number: 08),
//            Player(name: "Goody", number: 09),
//            Player(name: "Cohen", number: 10),
//            Player(name: "Frim", number: 11),
//            Player(name: "Wilko", number: 12),
//            Player(name: "Ash Carey", number: 13),
//            Player(name: "Bootsy", number: 14),
//            Player(name: "Van Denderen", number: 15),
//            Player(name: "Nate Dennis", number: 16),
//            Player(name: "Dan Petsinis", number: 17),
//            Player(name: "Stu Carey", number: 18),
//            Player(name: "Anthony Cvek", number: 19),
//            Player(name: "Hirsch", number: 20),
//            Player(name: "Heath Judd", number: 21),
//            Player(name: "Connor Huthwaite", number: 22)
//
//            // THIS IS PLAYER DATA W POSITION
////                    Player(name: "JB", number: 01, position: .Forward),
////                    Player(name: "Julius Waras-Carstensen", number: 02, position: .Forward),
////                    Player(name: "J Ludik", number: 03, position: .Forward),
////                    Player(name: "Smout", number: 04, position: .Forward),
////                    Player(name: "Kye Cherian", number: 05, position: .Forward),
////                    Player(name: "P Falvo", number: 06, position: .Forward),
////                    Player(name: "Chad Kadish", number: 07, position: .Midfield),
////                    Player(name: "Richo", number: 08, position: .Midfield),
////                    Player(name: "Goody", number: 09, position: .Midfield),
////                    Player(name: "Cohen", number: 10, position: .Midfield),
////                    Player(name: "Frim", number: 11, position: .Midfield),
////                    Player(name: "Wilko", number: 12, position: .Midfield),
////                    Player(name: "Ash Carey", number: 13, position: .Back),
////                    Player(name: "Bootsy", number: 14, position: .Back),
////                    Player(name: "Van Denderen", number: 15, position: .Back),
////                    Player(name: "Nate Dennis", number: 16, position: .Back),
////                    Player(name: "Dan Petsinis", number: 17, position: .Back),
////                    Player(name: "Stu Carey", number: 18, position: .Back),
////                    Player(name: "Anthony Cvek", number: 19, position: .Bench),
////                    Player(name: "Hirsch", number: 20, position: .Bench),
////                    Player(name: "Heath Judd", number: 21, position: .Bench),
////                    Player(name: "Connor Huthwaite", number: 22, position: .Bench)
//            ])
//    }
//}

//Player(name: "JB", number: 01, position: .Forward),
//Player(name: "Julius Waras-Carstensen", number: 02, position: .Forward),
//Player(name: "J Ludik", number: 03, position: .Forward),
//Player(name: "Smout", number: 04, position: .Forward),
//Player(name: "Kye Cherian", number: 05),
//Player(name: "P Falvo", number: 06),
//Player(name: "Chad Kadish", number: 07),
//Player(name: "Richo", number: 08),
//Player(name: "Goody", number: 09),
//Player(name: "Cohen", number: 10),
//Player(name: "Frim", number: 11),
//Player(name: "Wilko", number: 12),
//Player(name: "Ash Carey", number: 13),
//Player(name: "Bootsy", number: 14),
//Player(name: "Van Denderen", number: 15),
//Player(name: "Nate Dennis", number: 16),
//Player(name: "Dan Petsinis", number: 17),
//Player(name: "Stu Carey", number: 18),
//Player(name: "Anthony Cvek", number: 19),
//Player(name: "Hirsch", number: 20),
//Player(name: "Heath Judd", number: 21),
//Player(name: "Connor Huthwaite", number: 22)

//[Player(name: "Test1", number: 01),
// Player(name: "Test2", number: 02),
// Player(name: "Test3", number: 03),
// Player(name: "Test4", number: 04),
// Player(name: "Test5", number: 05),
// Player(name: "Test6", number: 06),
// Player(name: "Test7", number: 07),
// Player(name: "Test8", number: 08),
// Player(name: "Test9", number: 09),
// Player(name: "Test10", number: 10),
// Player(name: "Test11", number: 11),
// Player(name: "Test12", number: 12),
// Player(name: "Test13", number: 13),
// Player(name: "Test14", number: 14),
// Player(name: "Test15", number: 15),
// Player(name: "Test16", number: 16),
// Player(name: "Test17", number: 17),
// Player(name: "Test18", number: 18),
// Player(name: "Bench1", number: 19),
// Player(name: "Bench2", number: 20),
// Player(name: "Bench3", number: 21),
// Player(name: "Bench4", number: 22)
//]
