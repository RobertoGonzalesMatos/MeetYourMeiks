//
//  NewItemViewModel.swift
//  TSQ
//
//  Created by Roberto Gonzales on 7/30/23.
//


import FirebaseStorage
import FirebaseFirestore
import Foundation
import FirebaseAuth
import UIKit
import SwiftUI

class ImageViewModel: ObservableObject{
    @State var image: UIImage?
    @State var loaded = false
    
    func saveData(Meik: Meik) {
        let db = Firestore.firestore()

        db.collection("DataTaps")
            .document("year")
            .setData([Meik.year: FieldValue.increment(1.0)], merge: true)
        
        db.collection("DataTaps")
            .document("email")
            .setData([Meik.email: FieldValue.increment(1.0)], merge: true)
        
        for i in Meik.concentration.split(separator: " and ") {
            db.collection("DataTaps")
                .document("concentration")
                .setData([String(i): FieldValue.increment(1.0)], merge: true)
        }
    }
    
    func save(image: UIImage){
        let storageRef = Storage.storage().reference()
        
        let Image = image.jpegData(compressionQuality: 0.8)
        
        guard Image != nil else{
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let path = "images/\(uId).jpg"
        
        let fileRef = storageRef.child(path)
        _ = fileRef.putData(Image!, metadata: nil) { metadata, error in
        }
    }
    
    func retrieve(path: String, version: Int, completion: @escaping (UIImage) -> Void) {
        let modPath = String(path.dropFirst(7))
        let fileURL = documentsUrl.appendingPathComponent(modPath)
        if UIImage(contentsOfFile: fileURL.path()) != nil && getLocalImageVersion(email: modPath) == version{
            print("This was saved and is used locally: " + modPath)
            completion(UIImage(contentsOfFile: fileURL.path())!)
        }else{
            let imageRef = Storage.storage().reference().child(path)
            imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else if let imageData = data {
                    if let uiImage = UIImage(data: imageData) {
                        print("This is gonna be saved: " + modPath)
                        self.replaceImage(originalImagePath: modPath, newImage: uiImage, version: version)
                        completion(uiImage)
                    } else {
                        print("Failed to create UIImage from data.")
                        completion(UIImage(systemName: "person.circle")!)
                    }
                }
            }
        }
    }
    func replaceImage(originalImagePath: String, newImage: UIImage, version: Int) {
        
        guard let data = newImage.jpegData(compressionQuality: 1) ?? newImage.pngData() else {
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) as NSURL else {
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(originalImagePath)!)
            setLocalImageVersion(email: originalImagePath, version: version)
            print(getLocalImageVersion(email: originalImagePath))
            return
        } catch {
            print(error.localizedDescription)
            return
        }
        
    }
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    func setLocalImageVersion(email: String, version: Int) {
        UserDefaults.standard.set(version, forKey: email)
    }

    func getLocalImageVersion(email: String) -> Int {
        print(UserDefaults.standard.integer(forKey: email))
        return UserDefaults.standard.integer(forKey: email)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}


