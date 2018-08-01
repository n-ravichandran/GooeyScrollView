//
//  GooeyScrollView.swift
//  GooeyHeaderExample
//
//  Created by Niranjan Ravichandran on 8/1/18.
//  Copyright © 2018 Niranjan Ravichandran. All rights reserved.
//

import UIKit

class GooeyScrollView: UIScrollView {

    var headerContainer: UIView!
    var headerImage: UIImageView!
    var detachHeader = false
    
    private weak var parentViewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        headerContainer = UIView(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.3))
        headerContainer.backgroundColor = UIColor.clear
        self.addSubview(headerContainer)
        
        headerImage = UIImageView(frame: headerContainer.bounds)
        headerImage.contentMode = .scaleAspectFill
        headerImage.clipsToBounds = true
        headerImage.backgroundColor = UIColor(white: 0, alpha: 0.15)
        headerContainer.addSubview(headerImage)
        self.contentSize.height = headerContainer.frame.height
        self.alwaysBounceVertical = true

    }
    
    func activateConstraints() {
        if self.superview == nil {
            return
        }
        //Adding Auto-layout constraints for header image
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: headerImage, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.priority = .defaultHigh
        let bottomConstraint = NSLayoutConstraint(item: headerImage, attribute: .bottom, relatedBy: .equal, toItem: self.headerContainer, attribute: .bottom, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: headerImage, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: headerContainer, attribute: .height, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: headerImage, attribute: .width, relatedBy: .equal, toItem: headerContainer, attribute: .width, multiplier: 1, constant: 0)
        heightConstraint.priority = .required
        self.superview!.addConstraints([topConstraint, bottomConstraint, widthConstraint, heightConstraint])
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.activateConstraints()
        self.getParent()
    }
    
    private func getParent() {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                self.parentViewController = viewController
                return
            }
        }
    }
    
    override var contentOffset: CGPoint {
        didSet {
            if !detachHeader {
                return
            }
            
            if headerContainer == nil {
                //Return if the headerContainer is not setup yet
                return
            }
            
            let yPoint = contentOffset.y
            let startPoint = self.headerContainer.frame.height - (self.parentViewController?.navigationController?.navigationBar.frame.maxY ?? 0)
            
            if yPoint >= startPoint {
                //we have scrolled passed header content. Show navigation bar
                self.parentViewController?.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.parentViewController?.navigationController?.navigationBar.shadowImage = nil
            } else {
                self.parentViewController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.parentViewController?.navigationController?.navigationBar.shadowImage = UIImage()
            }
        }
    }

}
