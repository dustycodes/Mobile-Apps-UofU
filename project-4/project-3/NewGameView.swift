//
//  NewGameView.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol CreateGameDelegate {
    func createGame(name: String, player1: String)
}

class NewGameView: UIView, UITextFieldDelegate {
    // Private Member variables
    private var _game: Game = Game()
    private var titleField: UITextField = UITextField(frame: CGRectZero)
    private var playerOneField: UITextField = UITextField(frame: CGRectZero)
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
        
        createButton = UIButton(frame: CGRect(x: self.bounds.width/10, y: start_height+8*h, width: self.bounds.width*6/8, height: self.bounds.height*1/10))
        createButton.setTitle("Create", forState: UIControlState.Normal)
        createButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        createButton.backgroundColor = UIColor.lightGrayColor()
        
        // Set up delegates
        titleField.delegate = self
        playerOneField.delegate = self
        createButton.addTarget(self, action: "createGame:", forControlEvents: UIControlEvents.TouchUpInside)

        addSubview(title)
        addSubview(titleField)
        addSubview(playerOne)
        addSubview(playerOneField)
        addSubview(createButton)
    }
    
    // Delegates
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func createGame(button: UIButton) {
        //_game.create(titleField.text!, player1: playerOneField.text!)
        delegate?.createGame(titleField.text!, player1: playerOneField.text!)
    }
    
    // Public methods
    func clear() {
        _game = Game()
        titleField.text! = "New Game"
        playerOneField.text! = "Player One"
    }
}
