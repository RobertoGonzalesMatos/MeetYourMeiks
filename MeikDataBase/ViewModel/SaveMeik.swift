//
//  NewSQItemViewModel.swift
//  TSQ
//
//  Created by Roberto Gonzales on 8/7/23.
//

//
//  NewItemViewModel.swift
//  TSQ
//
//  Created by Roberto Gonzales on 7/30/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class SaveMeik: ObservableObject{
    
    @Published var imageURL = 0
    @Published var concentration = ""
    @Published var name = ""
    @Published var location = ""
    @Published var tags = ""
    @Published var text = ""
    @Published var year = ""
    @Published var email = ""
    
    init(){}
    
    func save(){
        
        guard let newId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let setWithoutDuplicates = Set(tags.split(separator: ", ").map { String($0) })
        let arrayWithoutDuplicates = Array(setWithoutDuplicates)
        
        let newItem = Meik(imageURL: imageURL, id: newId, concentration: concentration, name: name, location: location,year: year, email: email, text: text, tags: arrayWithoutDuplicates)
        
        let db = Firestore.firestore()
        
        db.collection("meiks")
            .document(newId)
            .setData(newItem.asDictionary())
    }

}

