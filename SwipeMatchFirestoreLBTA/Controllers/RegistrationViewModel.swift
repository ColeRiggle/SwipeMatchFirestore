//
//  RegistrationViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 9/23/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email else { return }
        guard let password = password else { return }
        
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { [unowned self] (result, error) in
            if let error = error {
                completion(error)
                return
            }
            
            print("Successfully registered user: ", result?.user.uid ?? "")
            
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            ref.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    completion(error)
                    return
                }
                
                print("Finished uploading image to storage")
                
                ref.downloadURL { (url, error) in
                    if let error = error {
                        completion(error)
                        return
                    }

                    self.bindableIsRegistering.value = false
                    print("Download url of our image is: " , url?.absoluteURL ?? "")
                }
            }
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
        bindableIsFormValid.observer?(isFormValid)
    }
    
    var bindableIsFormValid = Bindable<Bool>()
    
}
