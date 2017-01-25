//
//  PaintingsListViewController.swift
//  project-2
//
//  Created by Dusty Argyle on 2/18/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class PaintingsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    
    //declare the necessary components for the collection view
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout?
    
    //get the instance of the model, if it has never been instantiated it will instantiate it for the first time
    //otherwise if will just return the previous instantation
    var paintingCollection2 = PaintingCollection.sharedInstance

    override func viewDidLoad()
    {
        //determine how you have the cells to be laid out
        layout = UICollectionViewFlowLayout()
        layout!.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout!.itemSize = CGSize(width: self.view.frame.width/5, height: self.view.frame.height/5)
        
        //set up everything for the collection view
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(MyCustomCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionView.self))
        
        collectionView.backgroundColor = UIColor.blackColor()
        
        //TODO: note that this is not thwere you will want to add painting to the painting view
        paintingCollection2 = PaintingCollection()
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addPainting:")
        self.navigationItem.rightBarButtonItem = addButton
        
        //add the collection view to the subview
        view.addSubview(collectionView)
    }
    
    func addPainting(sender: UIBarButtonItem) {
        paintingCollection2.addPainting(Painting())
//        let nsip: NSIndexPath = NSIndexPath(forItem: paintingCollection2.count-1, inSection: 0)
//        print("Adding painting to \(nsip.item) section \(nsip.section)")
//        var nsipa: [NSIndexPath] = []
//        nsipa.append(nsip)
//        collectionView.reloadSections(NSIndexSet()
        //collectionView.reloadItemsAtIndexPaths(nsipa)
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return paintingCollection2.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MyCustomCell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionView.self), forIndexPath: indexPath) as! MyCustomCell
        
        //get the painting objects
        let painting = paintingCollection2.paintingWithIndex(indexPath.item)
        print("Adding painting to \(indexPath.item) section \(indexPath.section)")
        
        //draw the correct painting in the painting view
        cell.drawPainting(painting)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let paintingViewController: PaintingViewController = PaintingViewController()
        
        //get correct painting collection
        let painting = paintingCollection2.paintingWithIndex(indexPath.item)
        paintingViewController.paintingView.painting = painting
        
        navigationController?.pushViewController(paintingViewController, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        //collectionView.reloadInputViews()
        //collectionView.setNeedsDisplay()
        collectionView.reloadData()
        
    }

}
