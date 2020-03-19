import LBTATools
import UIKit

class TransactionCell: UICollectionViewCell {
    
    var messageText: UILabel = {
        var lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.white
        lb.isUserInteractionEnabled = true
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    func setUpUI() {
        
        
    }
}
