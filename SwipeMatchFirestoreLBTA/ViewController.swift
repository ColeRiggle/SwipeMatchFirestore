//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/5/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let grayView = UIView()
        grayView.backgroundColor = .gray
        
        let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        
        let redView = UIStackView(arrangedSubviews: subviews)
        redView.distribution = .fillEqually
        redView.backgroundColor = .red
        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [redView, blueView, yellowView])
//        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)

        stackView.fillSuperview()
    }
    
}
