//
//  RegistrationController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/17/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button;
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = #colorLiteral(red: 0.8108462691, green: 0.09795912355, blue: 0.3279393613, alpha: 1)
        button.layer.cornerRadius = 22
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    let fullNameTextLabel: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter full name"
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers();
    }
    
    // MARK:- private
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        print("keyboard will show")
    }
    
    fileprivate func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            selectPhotoButton,
            fullNameTextLabel,
            emailTextField,
            passwordTextField,
            registerButton
        ])
        
        view.addSubview(stackView);
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9835382104, green: 0.380017519, blue: 0.3713539839, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8869333863, green: 0.106999211, blue: 0.4576653242, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}
