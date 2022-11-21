//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by ALFA on 21.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func imageLoad(){
        
    }
    
    func gestureTap()  {
        
        let tiklandimi = UITapGestureRecognizer(target: self, action: #selector(imageLoad))
        
        
    }


}
