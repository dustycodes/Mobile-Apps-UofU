//
//  ButtonCell.swift
//  project-3
//
//  Created by Dusty Argyle on 3/17/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell
{
    //let paintingView: UIView = UIView()
    var titleView: UILabel = UILabel()
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect())
        setUpScreen()
    }
    
    func setUpScreen()
    {
        titleView.drawRect(self.frame)
        
        addSubview(titleView)
    }
    
    override func layoutSubviews()
    {
        self.titleView.frame = self.bounds
        titleView.backgroundColor = UIColor.lightGrayColor()
        titleView.textAlignment = .Center
    }
    
    override func prepareForReuse()
    {
        titleView.text = ""
    }
    
    func setLabel(coordinate : String)
    {
        titleView.text = coordinate
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}