//
//  APIManager.swift
//  CarsUI
//
//  Created by Владислав Баранов on 08.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import SwiftUI
import FirebaseStorage
import FirebaseDatabaseSwift
import Firebase

class APIManager {
    
    static let shared = APIManager()
    
    
    //MARK: - Configure
    private func configureFB() -> Firestore {
        var db : Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        return db
    }
    
    //MARK: - GET

    func getMarks(completion: @escaping (([Company])->Void?)){
        let db = configureFB()
        let collectionRef = db.collection("Cars").document("Comp")
        
        collectionRef.getDocument { (document, error) in
            var someArray : [Company] = []
            
            let data = document!.get("companies") as! [String]
            for (index, current) in data.enumerated() {
                someArray.append(Company(id: index, car: current, carModels: []))
            }
            
            completion(someArray)
        }
    }
    
    func getModels(company: String, completion: @escaping (([Models])->Void?)){
        let db = configureFB()
        let collectionRef = db.collection("Cars").document("Comp").collection(company)
        
        collectionRef.getDocuments { (document, error) in
            var someArray : [Models] = []
            
            let data = document!.documents
            for (index, current) in data.enumerated() {
                someArray.append(Models(id: index, name: current.documentID, info: "", imageName: ""))
            }
            
            completion(someArray)
        }
    }
    
    func getInfo(company: String, model : String, completion: @escaping((Models) -> Void?)){
        let db = configureFB()
        let documentRef = db.collection("Cars").document("Comp").collection(company).document(model).getDocument{ (document, error) in
            
            var currentModel = Models(id: 0, name: model, info: document?.get("info") as! String, imageName: document?.get("image") as! String)
            
             completion(currentModel)
        }

        
    }

    
    func getImage(picName: String, completion: @escaping (Image) -> Void) {
        
        print("picName : ", picName)
        
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("images")
        
        var image: Image = Image("default")
        
        let fireRef = pathRef.child(picName + ".jpg")
        fireRef.getData(maxSize: 1920*1080) {
            (data, error) in
            
            guard error == nil else {
                print("ERROR: \(String(describing: error))")
                completion(image)
                return
            }
            
            let uiImage = UIImage(data: data!)!
            image = Image(uiImage: uiImage)
            
            completion(image)
            
            
        }
    }
    
    //MARK: - Register
    func register(email: String, password: String, completion: @escaping ((Bool) -> Void?)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                print("ERROR: \(String(describing: error))")
                completion(false)
                return
            }
            
            
            completion(true)
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((Bool) -> Void?)) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            guard error == nil else {
                print("ERROR: \(String(describing: error))")
                completion(false)
                return
            }
            
            completion(true)
        }
        
        
    }
    
}

