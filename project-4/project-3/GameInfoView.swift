//
//  NewGameView.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol PlayGameDelegate {
    func playGame(game: Game)
}

class GameInfoView: UIView, UITextFieldDelegate {
    // Private Member variables
    private var _game: Game = Game()
    private var titleField: UILabel = UILabel(frame: CGRectZero)
    private var playerOneField: UILabel = UILabel(frame: CGRectZero)
    private var playerTwoField: UITextField = UITextField(frame: CGRectZero)
    private var winnerField: UILabel = UILabel(frame: CGRectZero)
    private var missilesField: UILabel = UILabel(frame: CGRectZero)
    private var playButton: UIButton = UIButton(frame: CGRectZero)
    
    var delegate: PlayGameDelegate?
    
    // Accessors
    var game: Game {
        get { return _game }
        set {
            _game = newValue
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    //Constructors
    override init(frame: CGRect) {
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    // View methods
    override func layoutSubviews() {
        //clear subviews
        subviews.forEach({ $0.removeFromSuperview() })
        
        let label_left = self.bounds.width/15
        let field_left = self.bounds.width/12
        let start_height = self.bounds.height/10
        let w = self.bounds.width*6/8
        let h = self.bounds.height/16
        
        let title: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height, width: w, height: h))
        title.textColor = UIColor.whiteColor()
        title.text = "Game Title"
        titleField = UILabel(frame: CGRect(x: field_left, y: start_height+h, width: w, height: h))
        titleField.backgroundColor = UIColor.whiteColor()
        titleField.text = _game.name
        
        let playerOne: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height+2*h, width: w, height: h))
        playerOne.textColor = UIColor.whiteColor()
        playerOne.text = "First Player's Name"
        playerOneField = UILabel(frame: CGRect(x: field_left, y: start_height+3*h, width: w, height: h))
        playerOneField.backgroundColor = UIColor.whiteColor()
        playerOneField.text = _game.player1
        
        let playerTwo: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height+4*h, width: w, height: h))
        playerTwo.textColor = UIColor.whiteColor()
        playerTwo.text = "Second Player's Name"
        playerTwoField = UITextField(frame: CGRect(x: field_left, y: start_height+5*h, width: w, height: h))
        playerTwoField.backgroundColor = UIColor.whiteColor()
        
        let winner: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height+6*h, width: w, height: h))
        winner.textColor = UIColor.whiteColor()
        winner.text = "Winner"
        winnerField = UILabel(frame: CGRect(x: field_left, y: start_height+7*h, width: w, height: h))
        winnerField.backgroundColor = UIColor.whiteColor()
        winnerField.text = game.winner
        
        playButton = UIButton(frame: CGRect(x: self.bounds.width/10, y: start_height+10*h, width: self.bounds.width*6/8, height: self.bounds.height*1/10))
        playButton.setTitle("Join", forState: UIControlState.Normal)
        playButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        playButton.backgroundColor = UIColor.lightGrayColor()
        
        // Set up delegates
        playButton.addTarget(self, action: "playGame:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if(_game.gameSummary.state == GameState.Waiting) {
            addSubview(playButton)
        }
        
        addSubview(title)
        addSubview(titleField)
        addSubview(playerOne)
        addSubview(playerOneField)
        addSubview(playerTwo)
        addSubview(playerTwoField)
        addSubview(winner)
        addSubview(winnerField)
    }
    
    // Delegates
    func playGame(button: UIButton) {
        _game.player1 = playerTwoField.text!
        delegate?.playGame(_game)
    }
    
    // Public methods
}
