//
//  PopoverViewController.swift
//  SimplePopUp
//
//  Created by Инна Чистякова on 14.07.2023.
//

import Foundation
import UIKit

class PopoverViewController: UIViewController {
    
    // MARK: Constants & properties
    
    let largeSize: CGSize = CGSize(width: 300, height: 280)
    let smallSize: CGSize = CGSize(width: 300, height: 150)
    let margin: CGFloat = 10
    
    var sizeSegment: UISegmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewSettings()
        setupCloseButton()
        setupSizeSegment()
    }
    
    // MARK: Setup
    
    func setupViewSettings() {
        view.backgroundColor = .white
        view.layer.cornerRadius = margin
        
        preferredContentSize = largeSize
        popoverPresentationController?.presentedViewController.preferredContentSize = largeSize
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupCloseButton() {
        let closeAction = UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            
            guard let popover = self?.popoverPresentationController else { return }
            popover.delegate?.presentationControllerDidDismiss?(popover)
        })
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: closeAction, menu: nil)
    }
    
    func setupSizeSegment() {
        sizeSegment.selectedSegmentIndex = 0
        sizeSegment.backgroundColor = .systemGray5
        sizeSegment.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = sizeSegment
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        preferredContentSize = (sender.selectedSegmentIndex == 0) ? largeSize : smallSize
        popoverPresentationController?.presentedViewController.preferredContentSize = (sender.selectedSegmentIndex == 0) ? largeSize : smallSize
    }
}
