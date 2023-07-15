//
//  ViewController.swift
//  SimplePopUp
//
//  Created by Инна Чистякова on 13.07.2023.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let button: UIButton = UIButton()

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame.size = CGSize(width: 100, height: 44)
        button.center.x = view.frame.width/2
        button.frame.origin.y = view.safeAreaInsets.top
    }

    // MARK: Setup
    
    func setupButton() {
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = .none
        button.backgroundColor = .none
        
        button.addTarget(self, action: #selector(showPicker(sender:)), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func showPicker(sender: UIButton) {
        let popover = UINavigationController(rootViewController: PopoverViewController())
        popover.modalPresentationStyle = .popover
        popover.popoverPresentationController?.sourceView = sender
        popover.popoverPresentationController?.sourceRect = sender.bounds
        popover.popoverPresentationController?.permittedArrowDirections = .up
        popover.popoverPresentationController?.delegate = self
        
        self.present(popover, animated: true)
    }

    // MARK: UIPopoverPresentationControllerDelegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    public func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        button.setTitleColor(.lightGray, for: .normal)
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        button.setTitleColor(.systemBlue, for: .normal)
    }
}
