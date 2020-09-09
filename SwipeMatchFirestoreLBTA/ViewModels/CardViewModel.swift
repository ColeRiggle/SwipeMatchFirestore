//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/8/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
