import LBTATools
import UIKit

class TransactionCell: UICollectionViewCell {
    
    var isReceived: Bool? {
        didSet {
            if isReceived == true {
                stateContainerLabel.text = "Received"
                stateContainerLabel.textColor = UIColor(named: "Received Transaction Text")
                
                stateContainerView.backgroundColor = UIColor(named: "Received Transaction Button")
            } else {
                stateContainerLabel.text = "Sent"
                stateContainerLabel.textColor = UIColor(named: "Sent Transaction Text")
                
                stateContainerView.backgroundColor = UIColor(named: "Sent Transaction Button")
            }
        }
    }
    
    lazy var stateContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Received Transaction Button")
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var stateContainerLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.text = "Received"
        label.textColor = UIColor(named: "Received Transaction Text")
        return label
    }()

    lazy var receiverNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Francis Hardy"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(named: "Small Titles")
        return label
    }()
    
    lazy var transactionAmountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "$124.7"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = UIColor(named: "Large Titles")
        return label
    }()
    
    lazy var receiverImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "prueba"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
        calculateFontSizes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    func setUpUI() {
        
        contentView.addSubviewForAutolayout(receiverImageView)
        // receiverImageView.withSize(CGSize(width: 60, height: 60))
        NSLayoutConstraint.activate([
            receiverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            receiverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
        
        contentView.addSubviewForAutolayout(receiverNameLabel)
        NSLayoutConstraint.activate([
            receiverNameLabel.centerYAnchor.constraint(equalTo: receiverImageView.centerYAnchor, constant: -12),
            receiverNameLabel.leadingAnchor.constraint(equalTo: receiverImageView.trailingAnchor, constant: 12)
        ])
        
        contentView.addSubviewForAutolayout(stateContainerView)
        stateContainerView.anchor(top: receiverNameLabel.bottomAnchor, leading: receiverNameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        stateContainerView.addSubviewForAutolayout(stateContainerLabel)
        NSLayoutConstraint.activate([
            stateContainerLabel.centerYAnchor.constraint(equalTo: stateContainerView.centerYAnchor),
            stateContainerLabel.trailingAnchor.constraint(equalTo: stateContainerView.trailingAnchor, constant: -6),
            stateContainerLabel.leadingAnchor.constraint(equalTo: stateContainerView.leadingAnchor, constant: 6)
        ])
        stateContainerView.heightAnchor.constraint(equalTo: stateContainerLabel.heightAnchor, constant: 10).isActive = true
        
        contentView.addSubviewForAutolayout(transactionAmountLabel)
        NSLayoutConstraint.activate([
            transactionAmountLabel.centerYAnchor.constraint(equalTo: receiverImageView.centerYAnchor),
            transactionAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
            // transactionAmountLabel.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>)
        ])
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
            
        case .iPhone4_4S:
            
            receiverImageView.withSize(CGSize(width: 50, height: 50))
            receiverImageView.layer.cornerRadius = 25
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 16)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 12)
            
            break
            
        case .iPhones_5_5s_5c_SE:
            
            receiverImageView.withSize(CGSize(width: 50, height: 50))
            receiverImageView.layer.cornerRadius = 25
    
            receiverNameLabel.font = UIFont.systemFont(ofSize: 16)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 12)
            
            break
            
            
        case .iPhones_6_6s_7_8:
            
            receiverImageView.withSize(CGSize(width: 50, height: 50))
            receiverImageView.layer.cornerRadius = 25
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 16)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 12)
            
            break
            
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 18)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            break
            
            
        case .iPhoneX:
            
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 18)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 22)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            break
            
        case .iPhoneXR:
            
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 18)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 22)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            break
            
        default:
            
            receiverImageView.withSize(CGSize(width: 60, height: 60))
            receiverImageView.layer.cornerRadius = 30
            
            receiverNameLabel.font = UIFont.systemFont(ofSize: 18)
            transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 22)
            
            stateContainerLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            break
            
        }
    }
}
