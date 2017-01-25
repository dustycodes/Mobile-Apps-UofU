

import UIKit

class MyCustomCell: UICollectionViewCell
{
    //let paintingView: UIView = UIView()
    var paintingView: PaintingView = PaintingView()
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect())
        
        setUpScreen()
    }
    
    func setUpScreen()
    {
        
        //TODO: if you need to do any inital set up the painting view then do it here
        paintingView.drawRect(self.frame)
        
        
        addSubview(paintingView)
    }
    
    override func layoutSubviews()
    {
        self.paintingView.frame = self.bounds
    }
    
    //this will get called when a cell is about to be reused, not every cell in a collection view is unique,
    //rather they will be reused numerous times to save resources. So make sure to clear out the old paiting
    //and replace it with the new painting that you want
    override func prepareForReuse()
    {
        paintingView.setPainting(Painting())
    }
    
    func drawPainting(painting : Painting)
    {
        paintingView.setPainting(painting)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
