//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by ALFA on 21.11.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore



class ProfileViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        gestureTap()
        imageSettings()
    }
    
    
    
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    func imageSettings()
    {
        image.layer.cornerRadius = 30
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize(width: 4, height: 4)
        image.layer.shadowRadius = 10
        
    }

    
    func gestureTap()  {
        
        image.isUserInteractionEnabled = true

        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageLoad))
        image.addGestureRecognizer(imageGesture)
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    @objc func imageLoad(){
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.sourceType = .photoLibrary
        pickercontroller.allowsEditing = false
        present(pickercontroller, animated: true)
        
        
        
    }
    


    @objc func hideKeyboard(){
        
        view.endEditing(true)
    }

    
    @IBAction func paylasButton(_ sender: Any) {
        

        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = image.image?.jpegData(compressionQuality: 0.3) {
            
            let uuıd = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuıd).jpg")
            imageReference.putData(data) { metaData, error in
                
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                } else {
                    imageReference.downloadURL { url,error in
                        
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            self.makeAlert(title: "Nice !", message: error?.localizedDescription ?? "Fotoğraf başarıyla yüklendi !")
                            
                            
                            // MARK: - DataBase
                            
                            let fireStoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            
                            let fireStorePost = [
                                "imageUrl":imageUrl!,
                                "postedBy": Auth.auth().currentUser!.email!,
                                "postComment":self.textView.text!,
                                "date":FieldValue.serverTimestamp(),
                                "likes":0]  as [String:Any]
                            
                            
                            firestoreReference = fireStoreDatabase.collection("Posts").addDocument(data: fireStorePost,completion: { error in
                                if error != nil {
                                    self.makeAlert(title: "Error !", message: error?.localizedDescription ?? "Error kayıt geçersiz")
                                } else {
                                    self.image.image = UIImage(named: "instagram")
                                    self.textView.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            })
                    
                        }
                        
                    }
                }
                
            }
                
        }
 
    }
    
    

}
extension ProfileViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
}
