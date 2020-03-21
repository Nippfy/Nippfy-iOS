import LBTATools
import UIKit

class RestaurantCell: UICollectionViewCell {
    
    var restaurantImageSize: CGFloat = 160
    var restaurantNameLabelFont: CGFloat = 22
    var distanceLabelFont: CGFloat = 16
    var locationImageSize: CGFloat = 20
    var spaceImageOutOfContent: CGFloat = 12
    var spaceBetweenBackgroundAndContentView: CGFloat = 12
    
    lazy var backgroundContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        return view    }()
    
    lazy var distanceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: distanceLabelFont)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.text = "Distance: 3.6 km"
        label.textColor = UIColor(named: "Normal Words")
        return label
    }()
    
    lazy var restauranteNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: restaurantNameLabelFont)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Spar Siete Palmas"
        label.textColor = UIColor(named: "Large Titles")
        return label
    }()
    
    lazy var restaurantImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "prueba"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var locationImageView: UIImageView = {
        let image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        let image2 = image?.maskWithColor(color: UIColor(named: "Received Transaction Text")!)
        var imageView = UIImageView(image: image2!)
        imageView.clipsToBounds = true
        // imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        calculateFontSizes()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    func setUpUI() {
        
        contentView.addSubviewForAutolayout(backgroundContainer)
        backgroundContainer.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: spaceBetweenBackgroundAndContentView, left: spaceBetweenBackgroundAndContentView, bottom: spaceBetweenBackgroundAndContentView, right: spaceBetweenBackgroundAndContentView), size: CGSize(width: 0, height: 0))
        
        backgroundContainer.addSubviewForAutolayout(restaurantImageView)
        NSLayoutConstraint.activate([
            restaurantImageView.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor),
            restaurantImageView.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: -spaceImageOutOfContent),
            restaurantImageView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: spaceImageOutOfContent)
        ])
        // receiverImageView.withWidth(120)
        restaurantImageView.withSize(CGSize(width: restaurantImageSize, height: restaurantImageSize))
        
        backgroundContainer.addSubviewForAutolayout(locationImageView)
        locationImageView.anchor(top: nil, leading: restaurantImageView.trailingAnchor, bottom: backgroundContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 0), size: CGSize(width: 0, height: 0))
        locationImageView.withSize(CGSize(width: locationImageSize, height: locationImageSize))
        
        backgroundContainer.addSubviewForAutolayout(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 6),
            distanceLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -12),
            distanceLabel.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -6)
        ])
        
        backgroundContainer.addSubviewForAutolayout(restauranteNameLabel)
        restauranteNameLabel.anchor(top: backgroundContainer.topAnchor, leading: locationImageView.leadingAnchor, bottom: nil, trailing: distanceLabel.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 6, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        // Small Devices
        if (deviceType == .iPhone4_4S || deviceType == .iPhones_5_5s_5c_SE || deviceType == .iPhones_6_6s_7_8) {
            
            restaurantImageSize = 100
            restaurantNameLabelFont = 16
            distanceLabelFont = 12
            locationImageSize = 12
            spaceImageOutOfContent = 12
            spaceBetweenBackgroundAndContentView = 12
            
        }
            // Large Devices
        else {
            restaurantImageSize = 160
            restaurantNameLabelFont = 22
            distanceLabelFont = 16
            locationImageSize = 20
            spaceImageOutOfContent = 12
            spaceBetweenBackgroundAndContentView = 12
        }
        
    }
}
