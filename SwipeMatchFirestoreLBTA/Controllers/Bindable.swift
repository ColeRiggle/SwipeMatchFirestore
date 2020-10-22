//
//  Bindable.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/24/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
