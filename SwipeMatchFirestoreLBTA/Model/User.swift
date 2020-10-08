//
//  User.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/8/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    // defining the properites for the model layer
    var name: String?
    var age: Int?
    var profession: String?
    //let imageNames: [String]
    var imageUrl1: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.name = dictionary["fullName"] as? String
        self.imageUrl1 = dictionary["imageUrl1"] as? String
        self.uid = dictionary["uid"] as? String
    }
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        
        attributedText.append(NSAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(profession ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
        
    }
}
