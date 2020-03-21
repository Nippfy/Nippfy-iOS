//
//  LoginView.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import LBTATools

class SearchView: UIView {
    
    var isScrollViewHidden: Bool? = true {
        didSet {
            if (isScrollViewHidden == true) {
                showScrollView()
            } else {
                hideScrollView()
            }
        }
    }
    
    // MARK: Scroll View and containers
    lazy var scrollView: DScrollView = {
        var scrollView = DScrollView()
        // scrollView.backgroundColor = .red
        return scrollView
    }()
    
    lazy var scrollViewContainer: DScrollViewContainer = {
        var scrollViewContainer = DScrollViewContainer(axis: .horizontal, spacing: 20)
        return scrollViewContainer
    }()
    
    lazy var scrollViewElement0: UIView = {
        var scrollViewElement = DScrollViewElement(width: 400)
        scrollViewElement.backgroundColor = .yellow
        return scrollViewElement
    }()
    
    lazy var scrollViewElement1: UIView = {
        var scrollViewElement = DScrollViewElement(width: 400)
        scrollViewElement.backgroundColor = .blue
        return scrollViewElement
    }()
    
    lazy var scrollViewContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var collectionViewContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.setImage(UIImage(named: "sliderx24"), for: .bookmark, state: .normal)
        
        searchBar.showsBookmarkButton = true
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    lazy var backgroundContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "Card Background")
        // view.backgroundColor = .blue
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var transactionsTopLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.text = "Transactions"
        label.textColor = UIColor(named: "Large Titles")
        return label
    }()
    
    lazy var transactionsCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "Card Background")
        return cv
    }()
    
    var scrollViewHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        setUpBackgroundContainer()
        setUpSearchBar()
        setUpScrollView()
        setUpCollectionView()
    }
    
    fileprivate func setUpCollectionView() {
        backgroundContainer.addSubviewForAutolayout(collectionViewContainerView)
        collectionViewContainerView.anchor(top: scrollViewContainerView.bottomAnchor, leading: scrollViewContainerView.leadingAnchor, bottom: backgroundContainer.bottomAnchor, trailing: scrollViewContainerView.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0), size: CGSize(width: 0, height: 0))
        
    }
    
    fileprivate func setUpScrollView() {
        backgroundContainer.addSubviewForAutolayout(scrollViewContainerView)
        scrollViewContainerView.anchor(top: searchBar.bottomAnchor, leading: searchBar.leadingAnchor, bottom: nil, trailing: searchBar.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        scrollViewHeight = scrollViewContainerView.heightAnchor.constraint(equalToConstant: 70)
        scrollViewHeight?.isActive = true
        
        addScrollView(in: scrollViewContainerView,
                      scrollView,
                      container: scrollViewContainer,
                      elements: [scrollViewElement0,scrollViewElement1])
    }
    
    fileprivate func setUpSearchBar() {
        backgroundContainer.addSubviewForAutolayout(searchBar)
        searchBar.anchor(top: backgroundContainer.topAnchor, leading: backgroundContainer.leadingAnchor, bottom: nil, trailing: backgroundContainer.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setUpBackgroundContainer() {
        addSubviewForAutolayout(backgroundContainer)
        backgroundContainer.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func calculateFontSizes() {
        let deviceType = UIDevice.current.deviceType
        
        // Small Devices
        if (deviceType == .iPhone4_4S || deviceType == .iPhones_5_5s_5c_SE || deviceType == .iPhones_6_6s_7_8) {
            
        }
            // Large Devices
        else {
            
            
        }
        
    }
    
    func showScrollView() {
        self.scrollViewHeight?.isActive = false
        self.scrollViewHeight = self.scrollViewContainerView.heightAnchor.constraint(equalToConstant: 70)
        self.scrollViewHeight?.isActive = true
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
    
    func hideScrollView() {
        self.scrollViewHeight?.isActive = false
        self.scrollViewHeight = self.scrollViewContainerView.heightAnchor.constraint(equalToConstant: 0)
        self.scrollViewHeight?.isActive = true
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
}
