//
//  NewGameView.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol CreateGameDelegate {
    func createGame(button: UIButton)
}

class NewGameView: UIView, UITextFieldDelegate {
    // Private Member variables
    private var _game: Game = Game(gameTitle: "New Game", gamePlayerOneName: "Player 1", gamePlayerTwoName: "Player 2")
    private var titleField: UITextField = UITextField(frame: CGRectZero)
    private var playerOneField: UITextField = UITextField(frame: CGRectZero)
    private var playerTwoField: UITextField = UITextField(frame: CGRectZero)
    private var createButton: UIButton = UIButton(frame: CGRectZero)
    
    var delegate: CreateGameDelegate?
    
    // Accessors
    var game: Game {
        get { return _game }
        set { _game = newValue }
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
        let start_height = self.bounds.height/4
        let w = self.bounds.width*6/8
        let h = self.bounds.height/16
        
        let title: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height, width: w, height: h))
        title.textColor = UIColor.whiteColor()
        title.text = "Game Title"
        titleField = UITextField(frame: CGRect(x: field_left, y: start_height+h, width: w, height: h))
        titleField.backgroundColor = UIColor.whiteColor()
        titleField.text = "New Game"
        
        let playerOne: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height+2*h, width: w, height: h))
        playerOne.textColor = UIColor.whiteColor()
        playerOne.text = "First Player's Name"
        playerOneField = UITextField(frame: CGRect(x: field_left, y: start_height+3*h, width: w, height: h))
        playerOneField.backgroundColor = UIColor.whiteColor()
        playerOneField.text = "player1"
        
        let playerTwo: UILabel = UILabel (frame: CGRect(x: label_left, y: start_height+4*h, width: w, height: h))
        playerTwo.textColor = UIColor.whiteColor()
        playerTwo.text = "Second Player's Name"
        playerTwoField = UITextField(frame: CGRect(x: field_left, y: start_height+5*h, width: w, height: h))
        playerTwoField.backgroundColor = UIColor.whiteColor()
        playerTwoField.text = "player2"
        
        createButton = UIButton(frame: CGRect(x: self.bounds.width/10, y: start_height+8*h, width: self.bounds.width*6/8, height: self.bounds.height*1/10))
        createButton.setTitle("Create", forState: UIControlState.Normal)
        createButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        createButton.backgroundColor = UIColor.lightGrayColor()
        
        // Set up delegates
        titleField.delegate = self
        playerOneField.delegate = self
        playerTwoField.delegate = self
        createButton.addTarget(self, action: "createGame:", forControlEvents: UIControlEvents.TouchUpInside)

        
        addSubview(title)
        addSubview(titleField)
        addSubview(playerOne)
        addSubview(playerOneField)
        addSubview(playerTwo)
        addSubview(playerTwoField)
        addSubview(createButton)
    }
    
    // Delegates
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func createGame(button: UIButton) {
        _game.title = titleField.text!
        _game.playerOneName = playerOneField.text!
        _game.playerTwoName = playerTwoField.text!
        delegate?.createGame(button)
    }
    
    // Public methods
    func clear() {
        _game = Game(gameTitle: "New Game", gamePlayerOneName: "Player 1", gamePlayerTwoName: "Player 2")
        titleField.text! = _game.title
        playerOneField.text! = _game.playerOneName
        playerTwoField.text! = _game.playerTwoName
    }
}
