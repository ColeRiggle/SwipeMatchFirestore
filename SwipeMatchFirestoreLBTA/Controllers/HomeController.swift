//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/5/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
            Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
        ] as [ProducesCardViewModel]
        
        let viewsModels = producers.map({ return $0.toCardViewModel()})
        return viewsModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach() { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    @objc fileprivate func handleSettings() {
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
    }
}
