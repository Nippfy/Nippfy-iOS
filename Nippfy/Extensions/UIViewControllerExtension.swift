import Foundation
import UIKit

extension UIViewController {
    
    func prepareToolbar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        navigationController?.isToolbarHidden = false
        
        var items = [UIBarButtonItem]()
        
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        // WALLET CONTROLLER
        
        let barButton = UIBarButtonItem(title: "Wallet", style: .plain, target: self, action: #selector(goToWalletController))
        // let barButton = UIBarButtonItem(image: UIImage(named: "caution_x24"), style: .plain, target: self, action: #selector(goToWalletController))
        items.append(barButton)
        
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
    }
    
    @objc private func goToWalletController() {
        let vc = WalletViewController()
        // vc.view.backgroundColor = .blue
        guard var viewControllers = navigationController?.viewControllers else { return }
        
        viewControllers.popLast()
        
        // Push targetViewController
        viewControllers.append(vc)
        
        navigationController?.setViewControllers(viewControllers, animated: false)
    }
    
}
