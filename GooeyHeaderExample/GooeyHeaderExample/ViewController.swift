//
//  ViewController.swift
//  GooeyHeaderExample
//
//  Created by Niranjan Ravichandran on 8/1/18.
//  Copyright © 2018 Niranjan Ravichandran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: GooeyScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = GooeyScrollView(frame: self.view.bounds)
        scrollView.headerImage.image = #imageLiteral(resourceName: "birdy")
        scrollView.detachHeader = true
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        self.addDummyViews()
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addDummyViews() {
        self.scrollView.contentSize.height += 25
        for _ in 0..<10 {
            let dummyView = UIView(frame: .init(x: 20, y: self.scrollView.contentSize.height, width: self.view.bounds.width - 40, height: 60))
            dummyView.backgroundColor = UIColor(white: 0, alpha: 0.15)
            dummyView.layer.cornerRadius = 6
            dummyView.clipsToBounds = true
            self.scrollView.addSubview(dummyView)
            self.scrollView.contentSize.height += dummyView.frame.height + 10
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }


}

