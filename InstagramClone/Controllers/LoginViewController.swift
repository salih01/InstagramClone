//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by ALFA on 21.11.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var kullaniciAdiTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var instagram: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      imageSettings()
        
 
    }
    
    func makeAlert(titleInput:String,messageInput:String) {
        
        var  alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        
        var alertAction = UIAlertAction(title: "Tamam", style: .default)
        
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }
    
    
    func imageSettings()
    {
        heart.layer.cornerRadius = 30
        instagram.layer.cornerRadius = 30
        instagram.layer.shadowColor = UIColor.black.cgColor
        instagram.layer.shadowOffset = CGSize(width: 4, height: 4)
        instagram.layer.shadowRadius = 10

    }

    
    @IBAction func loginButton(_ sender: Any) {
        
        if kullaniciAdiTextField.text! != "" && sifreTextField.text! != "" {
            Auth.auth().signIn(withEmail: kullaniciAdiTextField.text!, password: sifreTextField.text!){ (authData,error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Hata !", messageInput: "Abi böyle bi kullanıcı yok ya ")
                } else {
                    self.performSegue(withIdentifier: "goHome", sender: nil)
                }
                
            }
            
            
        }
        else
        {
            makeAlert(titleInput: "Hata !", messageInput: "Eksik veya hatalı girdiniz !")
        }
        
        
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if kullaniciAdiTextField.text != "" && sifreTextField.text != "" {
            
            Auth.auth().createUser(withEmail: kullaniciAdiTextField.text!, password: sifreTextField.text!) { (authdata,error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error!.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "goHome", sender: nil)
                }
                
            }
            
        }
        else {
            
            makeAlert(titleInput: "Hata !", messageInput: "Gadasını aldığım yanlış girdin")
            
        }

        
        
        
        
        
    }
    
}
