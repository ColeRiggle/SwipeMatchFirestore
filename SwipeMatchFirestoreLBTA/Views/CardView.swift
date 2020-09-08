//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/7/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

class CardView: UIView {

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "cole"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        imageView.contentMode = .scaleAspectFill
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        // rotation
        let translation = gesture.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let roationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = roationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    // Configuration
    fileprivate let threshold: CGFloat = 100
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.center = CGPoint(x: 1000 * translationDirection, y: 0)
            }
            self.transform = .identity
        }) { (_) in
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
