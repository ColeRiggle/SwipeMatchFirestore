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
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
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
                
                let imageURL = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageURL: imageURL, completion: completion)
            }
        }
    }

    fileprivate func saveInfoToFirestore(imageURL: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageURL]
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                completion(error)
                return
            }
            
            print("Saved info to firestore")
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
        bindableIsFormValid.observer?(isFormValid)
    }
    
    var bindableIsFormValid = Bindable<Bool>()
    
}
