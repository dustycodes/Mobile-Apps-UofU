//
//  GameView.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol StrikeDelegate {
    func strikeAttempt(button: UIButton)
}

class GameView: UIView {
    // Private Member variables
    private var _game: Game = Game(gameTitle: "New Game", gamePlayerOneName: "Player 1", gamePlayerTwoName: "Player 2")
    
    var delegate: StrikeDelegate?

    
    //Accessors
    var game: Game {
        get { return _game }
        set {
            _game = newValue
            setNeedsDisplay()
        }
    }
    
    // Constructors
    override init(frame: CGRect) {
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
        
        _game.startGame()
        
        let gameLabel: UILabel = UILabel(frame: CGRect(x: frame.width/2-100, y: 75, width: 200, height: 20))
        gameLabel.textColor = UIColor.whiteColor()
        if(_game.playerOneIsCurrentlyPlaying()) {
            gameLabel.text = "\(_game.playerOneName) is playing"
        }
        else {
            gameLabel.text = "\(_game.playerTwoName) is playing"
        }
        addSubview(gameLabel)
        
        var y_pos = 100
        for alpha in _game.getAlphas() {
            for numer in 1...10 {
                let x_pos = (numer-1) * Int(frame.width)/_game.getAlphas().count
                
                let nombre = "\(alpha)\(numer)"
                let button: UIButton = UIButton(frame: CGRect(x: x_pos, y: y_pos, width: 35, height: 35))
                button.setTitle(nombre, forState: UIControlState.Normal)

                if(_game.hasBeenStriked(nombre)) {
                    button.backgroundColor = UIColor.purpleColor()
                }
                else if(_game.hasBeenHit(nombre)) {
                    button.backgroundColor = UIColor.redColor()
                }
                else {
                    button.backgroundColor = UIColor.blueColor()
                }
                
                button.addTarget(self, action: "strikeAttempt:", forControlEvents: .TouchUpInside)
                addSubview(button)
            }
            y_pos += 35
        }
        
        let infoLabel: UILabel = UILabel(frame: CGRect(x: 20, y: y_pos, width: 200, height: 35))
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.text = _game.getAircraft()
        addSubview(infoLabel)
        
        let infoLabel1: UILabel = UILabel(frame: CGRect(x: 200, y: y_pos, width: 200, height: 35))
        infoLabel1.textColor = UIColor.whiteColor()
        infoLabel1.text = _game.getBattleship()
        addSubview(infoLabel1)
        y_pos += 35

        let infoLabel2: UILabel = UILabel(frame: CGRect(x: 20, y: y_pos, width: 200, height: 35))
        infoLabel2.textColor = UIColor.whiteColor()
        infoLabel2.text = _game.getSubmarine()
        addSubview(infoLabel2)

        let infoLabel3: UILabel = UILabel(frame: CGRect(x: 200, y: y_pos, width: 200, height: 35))
        infoLabel3.textColor = UIColor.whiteColor()
        infoLabel3.text = _game.getDestroyer()
        addSubview(infoLabel3)
        y_pos += 35

        let infoLabel4: UILabel = UILabel(frame: CGRect(x: 20, y: y_pos, width: 200, height: 35))
        infoLabel4.textColor = UIColor.whiteColor()
        infoLabel4.text = _game.getPatrol()
        addSubview(infoLabel4)

        let infoLabel5: UILabel = UILabel(frame: CGRect(x: 200, y: y_pos, width: 200, height: 35))
        infoLabel5.textColor = UIColor.whiteColor()
        infoLabel5.text = _game.getHits()
        addSubview(infoLabel5)
        y_pos += 35

//        let infoLabel6: UILabel = UILabel(frame: CGRect(x: 20, y: y_pos, width: 200, height: 35))
//        infoLabel6.textColor = UIColor.whiteColor()
//        infoLabel6.text = _game.getMisses()
//        addSubview(infoLabel6)

    }
    
    func strikeAttempt(button: UIButton) {
        //let coordinate = button.titleLabel!.text
        delegate?.strikeAttempt(button)
    }
    
}