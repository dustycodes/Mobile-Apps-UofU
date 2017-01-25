//
//  Game.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

class Game{
    // Private member variables
    private var _title: String = ""
    private var _playerOneName: String = ""
    private var _playerTwoName: String = ""
    private var _playerOneGrid: [String:String] = [:]
    private var _playerTwoGrid: [String:String] = [:]
    private var _alphas: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    private var _playerOneBoard: Bool = false
    private var _playerOneA: Int = 5
    private var _playerTwoA: Int = 5
    private var _playerOneB: Int = 4
    private var _playerTwoB: Int = 4
    private var _playerOneS: Int = 3
    private var _playerTwoS: Int = 3
    private var _playerOneD: Int = 2
    private var _playerTwoD: Int = 2
    private var _playerOneP: Int = 1
    private var _playerTwoP: Int = 1
    private var _playerOneHits: Int = 0
    private var _playerOneMisses: Int = 0
    private var _playerTwoHits: Int = 0
    private var _playerTwoMisses: Int = 0
    private var _started: Bool = false
    
    
    // Accessors
    var title: String {
        get { return _title }
        set {
            _title = newValue
        }
    }
    
    var playerOneName: String {
        get { return _playerOneName }
        set {
            _playerOneName = newValue
        }
    }
    
    var playerTwoName: String {
        get { return _playerTwoName }
        set {
            _playerTwoName = newValue
        }
    }
    
    // Constructor
    init(gameTitle: String, gamePlayerOneName: String, gamePlayerTwoName: String) {
        _title = gameTitle
        _playerOneName = gamePlayerOneName
        _playerTwoName = gamePlayerTwoName
    }
    init(game: NSDictionary) {
        //print(game)
        
        _playerOneA = (game["playerOneA"] as! NSString).integerValue
        _playerOneB = (game["playerOneB"] as! NSString).integerValue
        _playerOneBoard = (game["playerOneBoard"] as! NSString).boolValue
        _playerOneD = (game["playerOneD"] as! NSString).integerValue
        _playerOneGrid = (game["playerOneGrid"] as! NSDictionary) as! [String : String]
        //TODO test this works
        
        _playerOneHits = (game["playerOneHits"] as! NSString).integerValue
        _playerOneMisses = (game["playerOneMisses"] as! NSString).integerValue
        _playerOneName = (game["playerOneName"] as! NSString) as String
        _playerOneP = (game["playerOneP"] as! NSString).integerValue
        _playerOneS = (game["playerOneS"] as! NSString).integerValue
        _playerTwoA = (game["playerTwoA"] as! NSString).integerValue
        _playerTwoB = (game["playerTwoB"] as! NSString).integerValue
        _playerTwoD = (game["playerTwoD"] as! NSString).integerValue
        _playerTwoGrid = (game["playerTwoGrid"] as! NSDictionary) as! [String: String]
        // todo test this works
        
        _playerTwoHits = (game["playerTwoHits"] as! NSString).integerValue
        _playerTwoMisses = (game["playerTwoMisses"] as! NSString).integerValue
        _playerTwoName = (game["playerTwoName"] as! NSString) as String
        _playerTwoP = (game["playerTwoP"] as! NSString).integerValue
        _playerTwoS = (game["playerTwoS"] as! NSString).integerValue
        _started = (game["started"] as! NSString).boolValue
        _title = (game["title"] as! NSString) as String
        
        _alphas = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    }

    
    // Private functions
    private func placeAShip(code: String, size: Int, inout grid: [String:String]) {
        var placed = false
        while(!placed) {
            //let size: Int = 5
            //let code: String = "a"
            var start: String = ""
            let randchar: Int = random()%_alphas.count
            let letter: Character = _alphas[randchar]
            let number: Int = random()%10+1
            var temp: [String: String] = [:]
            var taken = false
            
            start.append(letter)
            start += String(number)
            let dice = random()%3+1
            switch dice {
            case 1:
                // diagnol right
                //Top and bottom bound
                if((number+size) <= 10 && (number+size) >= 1) {
                    //right bound
                    if(randchar + size <= _alphas.count) {
                        //Fits
                        for i in 0 ..< size {
                            let newloc = number + i
                            let newalp = _alphas[randchar + i]
                            let loc = "\(newalp)\(newloc)"
                            if(grid[loc] == nil) {
                                temp[loc] = code
                            }
                            else  {
                                taken = true
                                break;
                            }
                        }
                        if(!taken) {
                            for (key, value) in temp {
                                grid[key] = value
                            }
                            placed = true
                        }
                    }
                }
            case 2:
                // straight right
                //Top and bottom bound
                if((number+size) <= 10 && (number+size) >= 1) {
                    //right bound
                    if(randchar + size <= _alphas.count) {
                        //Fits
                        for i in 0 ..< size {
                            let newloc = number
                            let newalp = _alphas[randchar + i]
                            let loc = "\(newalp)\(newloc)"
                            if(grid[loc] == nil) {
                                temp[loc] = code
                            }
                            else  {
                                taken = true
                                break;
                            }
                        }
                        if(!taken) {
                            for (key, value) in temp {
                                grid[key] = value
                            }
                            placed = true
                        }
                    }
                }
            default:
                // straight down
                //Top and bottom bound
                if((number+size) <= 10 && (number+size) >= 1) {
                    //Fits
                    for i in 0 ..< size {
                        let newloc = number + i
                        let loc = "\(letter)\(newloc)"
                        if(grid[loc] == nil) {
                            temp[loc] = code
                        }
                        else  {
                            taken = true
                            break;
                        }
                    }
                    if(!taken) {
                        for (key, value) in temp {
                            grid[key] = value
                        }
                        placed = true
                    }
                }
            }
        }
    }
    
    //Private functions
    private func hitPlayerOne(code: String) {
        switch code {
        case "a":
            _playerOneA-=1
            _playerOneHits+=1
        case "b":
            _playerOneB-=1
            _playerOneHits+=1
        case "d":
            _playerOneD-=1
            _playerOneHits+=1
        case "s":
            _playerOneS-=1
            _playerOneHits+=1
        case "p":
            _playerOneP-=1
            _playerOneHits+=1
        default:
            return
        }
    }
    
    private func hitPlayerTwo(code: String) {
        switch code {
        case "a":
            _playerTwoA-=1
            _playerTwoHits+=1
        case "b":
            _playerTwoB-=1
            _playerTwoHits+=1
        case "d":
            _playerTwoD-=1
            _playerTwoHits+=1
        case "s":
            _playerTwoS-=1
            _playerTwoHits+=1
        case "p":
            _playerTwoP-=1
            _playerTwoHits+=1
        default:
            return
        }
    }
    
    //Public functions
//    func isValidCoordinate(coordinate: String) -> Bool {
//        let letter = coordinate[coordinate.startIndex]
//        if(_alphas.contains(letter)) {
//            let number = coordinate.substringWithRange(Range(start: coordinate.startIndex.advancedBy(1), end: coordinate.endIndex))
//            if(Int(number) > 0 || Int(number) < 11) {
//                return true
//            }
//            else {
//                return false
//            }
//        }
//        return false
//    }
    
    func checkWin() -> Bool {
        if(_playerOneBoard) {
            if(_playerOneHits >= 15) {
                return true
            }
            else {
                return false
            }
        }
        else {
            if(_playerTwoHits >= 15) {
                return true
            }
            else {
                return false
            }
        }
    }
    
    func getAlphas() -> [Character] {
        return _alphas
    }
    
    func getCurrentBoard() -> [String:String] {
        if(_playerOneBoard) {
            return _playerOneGrid
        }
        else  {
            return _playerTwoGrid
        }
    }
    
    func playerOneIsCurrentlyPlaying() -> Bool  {
        // if playerone is the current board, player 2 is shooting
        return !_playerOneBoard
    }
    
    func hasBeenStriked(coordinate: String) -> Bool {
        if(_playerOneBoard) {
            if(_playerOneGrid[coordinate] == "x") {
                return true
            }
            else {
                return false
            }
        }
        else {
            //player two board
            if(_playerTwoGrid[coordinate] == "x") {
                return true
            }
            else {
                return false
            }
        }
    }
    
    func hasBeenHit(coordinate: String) -> Bool {
        if(_playerOneBoard) {
            if(_playerOneGrid[coordinate] == "h") {
                return true
            }
            else {
                return false
            }
        }
        else {
            //player two board
            if(_playerTwoGrid[coordinate] == "h") {
                return true
            }
            else {
                return false
            }
        }
    }
    
    func getAircraft() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Aircraft Carrier: \(_playerOneA)"
        }
        else {
            info += "Aircraft Carrier: \(_playerTwoA)"
        }
        return info
    }
    
    func getBattleship() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Battleship: \(_playerOneB)"
        }
        else {
            info += "Battleship: \(_playerTwoB)"
        }
        return info
    }
    
    func getSubmarine() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Submarine: \(_playerOneS)"
        }
        else {
            info += "Submarine: \(_playerTwoS)"
        }
        return info
    }
    
    func getDestroyer() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Destroyer: \(_playerOneD)"
        }
        else {
            info += "Destroyer: \(_playerTwoD)"
        }
        return info
    }
    
    func getPatrol() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Patrol Boat: \(_playerOneP)"
        }
        else {
            info += "Patrol Boat: \(_playerTwoP)"
        }
        return info
    }
    
    func getMisses() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Misses: \(_playerOneMisses)"
        }
        else {
            info += "Misses: \(_playerTwoMisses)"
        }
        return info
    }
    
    func getHits() -> String {
        var info: String = ""
        if(playerOneIsCurrentlyPlaying()) {
            info += "Been Hit: \(_playerOneHits)"
        }
        else {
            info += "Been Hit: \(_playerTwoHits)"
        }
        return info
    }
    
    func startGame() {
        if(!_started) {
            placeShips()
            _started = true
        }
    }
    
    func strike(coordinate: String) -> Bool {
        if(_playerOneBoard) {
            //player one is being striked
            if(_playerOneGrid[coordinate] == nil) {
                _playerOneGrid[coordinate] = "x"
                _playerOneMisses++
                return false
            }
            else {
                //hit
                hitPlayerOne(_playerOneGrid[coordinate]!)
                _playerOneGrid[coordinate] = "h"
                return true
            }
        }
        else {
            //Player two is being striked
            if(_playerTwoGrid[coordinate] == nil) {
                _playerTwoGrid[coordinate] = "x"
                _playerTwoMisses++
                return false
            }
            else {
                //hit
                hitPlayerTwo(_playerTwoGrid[coordinate]!)
                _playerTwoGrid[coordinate] = "h"
                return true
            }
        }
    }
    
    func swapPlayers() {
        _playerOneBoard = !_playerOneBoard
    }
    
//    func save() {
//        let file = "\(_title).txt"
//        
//        let text = getJSON()
//        
//        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
//            let path = dir.stringByAppendingPathComponent(file);
//            
//            print(text)
//            
//            //writing
//            do {
//                try text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
//            }
//            catch {/* error handling here */}
//            
//            //reading
//            /*do {
//                let text2 = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
//            }
//            catch {/* error handling here */}*/
//        }
//    }
    
    func getJSON() -> String {
        var str: String = " "
        str += "{ "
        str += "\"title\": \"\(title)\", "
        str += "\"playerOneName\": \"\(_playerOneName)\", "
        str += "\"playerTwoName\": \"\(_playerTwoName)\", "
        
        str += "\"playerOneGrid\": {"
        for (key, value) in _playerOneGrid {
            str += "\"\(key)\": \"\(value)\","
        }
        str = str.substringToIndex(str.endIndex.predecessor())
        
        str += "}, "
        
        str += "\"playerTwoGrid\": {"
        for (key, value) in _playerTwoGrid {
            str += "\"\(key)\": \"\(value)\","
        }
        str = str.substringToIndex(str.endIndex.predecessor())
        str += "}, "
        
        str += "\"playerOneBoard\": \"\(_playerOneBoard)\", "
        str += "\"playerOneA\": \"\(_playerOneA)\", "
        str += "\"playerOneB\": \"\(_playerOneB)\", "
        str += "\"playerOneS\": \"\(_playerOneS)\", "
        str += "\"playerOneD\": \"\(_playerOneD)\", "
        str += "\"playerOneP\": \"\(_playerOneP)\","
        str += "\"playerTwoA\": \"\(_playerTwoA)\", "
        str += "\"playerTwoB\": \"\(_playerTwoB)\", "
        str += "\"playerTwoS\": \"\(_playerTwoS)\", "
        str += "\"playerTwoD\": \"\(_playerTwoD)\", "
        str += "\"playerTwoP\": \"\(_playerTwoP)\", "
        str += "\"playerOneMisses\": \"\(_playerOneMisses)\", "
        str += "\"playerOneHits\": \"\(_playerOneHits)\", "
        str += "\"playerTwoHits\": \"\(_playerTwoHits)\", "
        str += "\"playerTwoMisses\": \"\(_playerTwoMisses)\", "
        str += "\"started\": \"\(_started)\"}"
        
        return str
    }
    
    func placeShips() {
        //Player one
        // Aircraft carrier = 5
        placeAShip("a", size: 5, grid: &_playerOneGrid)
        
        // Battleship = 4
        placeAShip("b", size: 4, grid: &_playerOneGrid)
        
        // Submarine = 3
        placeAShip("s", size: 3, grid: &_playerOneGrid)
        
        // Destroyer = 2
        placeAShip("d", size: 2, grid: &_playerOneGrid)
        
        // Patrol boat = 1
        placeAShip("p", size: 1, grid: &_playerOneGrid)
        
        //Player two
        // Aircraft carrier = 5
        placeAShip("a", size: 5, grid: &_playerTwoGrid)
        
        // Battleship = 4
        placeAShip("b", size: 4, grid: &_playerTwoGrid)
        
        // Submarine = 3
        placeAShip("s", size: 3, grid: &_playerTwoGrid)
        
        // Destroyer = 2
        placeAShip("d", size: 2, grid: &_playerTwoGrid)
        
        // Patrol boat = 1
        placeAShip("p", size: 1, grid: &_playerTwoGrid)
    }
    
}
