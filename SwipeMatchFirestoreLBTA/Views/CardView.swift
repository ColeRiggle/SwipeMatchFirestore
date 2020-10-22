//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/7/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardViewDelegate {
    func didTapMoreInfo()
}

class CardView: UIView {
    
    var delegate: CardViewDelegate?
    
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
            //            imageView.image = UIImage(named: imageName)
            // load the image using URL
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }
            
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            // setup bars
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = barSelectedColor
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (index, imageUrl) in
            
            if let url = URL(string: imageUrl ?? "") {
                imageView.sd_setImage(with: url)
            }
            
            self.barsStackView.arrangedSubviews.forEach { (view) in
                view.backgroundColor = self.barDeselectedColor
            }
            
            self.barsStackView.arrangedSubviews[index].backgroundColor = self.barSelectedColor
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "cole"))
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupPanGesture()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate var imageIndex = 0;
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1);
    fileprivate let barSelectedColor = UIColor.white
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceToNextPhoto = tapLocation.x > frame.width / 2
        if shouldAdvanceToNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMoreInfo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleMoreInfo() {
        self.delegate?.didTapMoreInfo()
    }
    
    fileprivate func setupLayout() {
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        
        // add a gradient layer
        setupGradientLayer()
        
        setupBarsStackView();
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 2
        
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 44, right: 44), size: .init(width: 44, height: 44))
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.2]
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    // called after the frame for the view has been established
    override func layoutSubviews() {
        gradientLayer.frame = frame
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.center = CGPoint(x: 600 * translationDirection, y: 0)
            }
            self.transform = .identity
        }) { (_) in
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
