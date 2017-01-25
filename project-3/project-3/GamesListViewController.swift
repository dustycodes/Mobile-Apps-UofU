//
//  GamesListViewController.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SaveGameDelegate
{
    
    //declare the necessary components for the collection view
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout?
    
    // Singleton datasource
    private var _games = Games.sharedInstance
    
    // Private variables
    var _gameAdded: Bool = false
    var _removeGame: Bool = false
    var newGameViewController: NewGameViewController = NewGameViewController()
    
    override func viewDidLoad()
    {
        
        //determine how you have the cells to be laid out
        layout = UICollectionViewFlowLayout()
        layout!.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout!.itemSize = CGSize(width: self.view.frame.width-20.0, height: self.view.frame.height/16)
        
        //set up everything for the collection view
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(GameCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionView.self))
        
        collectionView.backgroundColor = UIColor.blackColor()
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addGame:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let deleteButton = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteGame:")
        self.navigationItem.leftBarButtonItem = deleteButton
        
        //add the collection view to the subview
        view.addSubview(collectionView)
    }
    
    func addGame(sender: UIBarButtonItem) {
        // show new game view and add the game
        navigationController?.pushViewController(newGameViewController, animated: true)
    }
    
    func deleteGame(sender: UIBarButtonItem) {
        _removeGame = !_removeGame
        if(_removeGame) {
            let alertController = UIAlertController(title: "Remove a Game", message: "Select a game you would like to remove, or select the delete button again to cancel.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return _games.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: GameCell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionView.self), forIndexPath: indexPath) as! GameCell
        
        //get the painting objects
        let game = _games.getGameWithIndex(indexPath.item)
        
        //draw the correct painting in the painting view
        cell.drawGame(game)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if(_removeGame) {
            _games.removeGameWithIndex(indexPath.item)
            collectionView.reloadData()
            _removeGame = false
        }
        else  {
            let gameViewController: GameViewController = GameViewController()
            gameViewController.delegate = self
        
            //get correct painting collection
            let game = _games.getGameWithIndex(indexPath.item)
            gameViewController.setGame(game)
        
            navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView.reloadData()
    }
    
    func checkSave() {
        _games.saveGames()
    }
}