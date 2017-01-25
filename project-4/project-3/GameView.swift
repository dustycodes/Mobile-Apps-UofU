//
//  GameView.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol StrikeDelegate {
    func strikeAttempt(pid: String, xPos: Int, yPos: Int, completion: (hit: Bool, sunk: Int) -> ())
    func showAlert(title: String, message: String)
}

class GameView: UIView {
    // Private Member variables
    private var _game: Game
    private var _myTurn: Bool = false
    var delegate: StrikeDelegate?
    
    //Accessors
    var game: Game {
        get { return _game }
        set {
            _game = newValue
            
            /*_game.getBoards({
                dispatch_async(dispatch_get_main_queue()) {
                    self.setNeedsDisplay()
                }
            })*/
        }
    }
    
    var myTurn: Bool {
        get { return _myTurn }
        set {
            if(_myTurn == newValue) {
                return
            }
            else {
                _myTurn = newValue
                setNeedsLayout()
                setNeedsDisplay()
            }
        }
    }
    
    // Constructors
    override init(frame: CGRect) {
        _game = Game()
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override func layoutSubviews() {
        
        subviews.forEach({ $0.removeFromSuperview() })
        
        var b1: [AnyObject] = []
        var b2: [AnyObject] = []
        var ret: Bool = false
        
        if(_myTurn == true) {
            
            _game.getBoards({
                (board1, board2) in
                b1 = board1
                b2 = board2
                ret = true
            })
            while(ret == false) { }
            
                let gameLabel: UILabel = UILabel(frame: CGRect(x: self.frame.width/2-150, y: 100, width: 300, height: 20))
                gameLabel.textColor = UIColor.whiteColor()
                gameLabel.text = "Opponent's Board: Touch coordinate to launch missile"
                self.addSubview(gameLabel)
                
                
                for coordinate in b2 {
                    let xPos = coordinate["xPos"] as! Int
                    let yPos = coordinate["yPos"] as! Int
                    let status = coordinate["status"] as! String
                    
                    let x_pos = xPos*32
                    let y_pos = 125 + yPos*35
                    
                    let nombre = "\(xPos),\(yPos)"
                    let button: UIButton = UIButton(frame: CGRect(x: x_pos, y: y_pos, width: 30, height: 30))
                    button.setTitle(nombre, forState: UIControlState.Normal)
                    
                    if(status == "MISS") {
                        button.backgroundColor = UIColor.whiteColor()
                    }
                    else if(status == "HIT") {
                        button.backgroundColor = UIColor.redColor()
                    }
                    else {
                        button.backgroundColor = UIColor.blueColor()
                        button.addTarget(self, action: "strikeAttempt:", forControlEvents: .TouchUpInside)
                    }
                    
                    self.addSubview(button)
                }
        }
        else if(_game.gameSummary.state == GameState.InProgress) {
            _game.getBoards({
                (board1, board2) in
                b1 = board1
                b2 = board2
                ret = true
            })
            while(ret == false) { }
            
                let gameLabel: UILabel = UILabel(frame: CGRect(x: self.frame.width/2-150, y: 75, width: 300, height: 20))
                gameLabel.textColor = UIColor.whiteColor()
                gameLabel.text = "Your Board: incomming missiles! Shots fired!"
                self.addSubview(gameLabel)
                
                
                for coordinate in b1 {
                    let xPos = coordinate["xPos"] as! Int
                    let yPos = coordinate["yPos"] as! Int
                    let status = coordinate["status"] as! String
                    
                    let x_pos = xPos*32
                    let y_pos = 125 + yPos*35
                    
                    let nombre = "\(xPos),\(yPos)"
                    let button: UIButton = UIButton(frame: CGRect(x: x_pos, y: y_pos, width: 30, height: 30))
                    button.setTitle(nombre, forState: UIControlState.Normal)
                    
                    if(status == "MISS") {
                        button.backgroundColor = UIColor.whiteColor()
                    }
                    else if(status == "HIT") {
                        button.backgroundColor = UIColor.redColor()
                    }
                    else if(status == "SHIP") {
                        button.backgroundColor = UIColor.blackColor()
                    }
                    else {
                        button.backgroundColor = UIColor.blueColor()
                    }
                    self.addSubview(button)
                }
        }
        else {
            let waitLabel: UILabel = UILabel(frame: CGRect(x: self.frame.width/2-150, y: 75, width: 300, height: 20))
            waitLabel.text = "Waiting for another player to join..."
            waitLabel.textColor = UIColor.whiteColor()
            self.addSubview(waitLabel)
        }
    }
    
    func strikeAttempt(button: UIButton) {
        //let coordinate = button.titleLabel!.text
        let coordinate = button.titleLabel?.text
        let both = coordinate?.componentsSeparatedByString(",")
        let xPos = Int(both![0])
        let yPos = Int(both![1])
        
        delegate?.strikeAttempt(_game.player1Id, xPos: xPos!, yPos: yPos!, completion: {
            [weak self](hit, sunk) in
            
            if(self != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    self!._myTurn = false
                    self!.setNeedsLayout()
                    self!.setNeedsDisplay()
                }

                if(hit == true) {
                    if(sunk == 5) {
                        self?.delegate?.showAlert("HIT!", message: "You sunk the opponents Aircraft Carrier")
                    }
                    else if(sunk == 4){
                        self?.delegate?.showAlert("HIT!", message: "You sunk the opponents Battleship")
                    }
                    else if(sunk == 3){
                        self?.delegate?.showAlert("HIT!", message: "You sunk the opponents Submarine or Destroyer")
                    }
                    else if(sunk == 2){
                        self?.delegate?.showAlert("HIT!", message: "You sunk the opponents lil patrol boat")
                    }
                    else {
                        self?.delegate?.showAlert("HIT!", message: "You hit the opponents ship")
                    }
                }
                else {
                    self?.delegate?.showAlert("Miss...", message: "sorry bro")
                }

            }
        })
    }
}