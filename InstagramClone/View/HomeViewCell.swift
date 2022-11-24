//
//  HomeViewCell.swift
//  InstagramClone
//
//  Created by ALFA on 24.11.2022.
//

import UIKit


class HomeViewCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSettings()
    }
    
    func imageSettings()  {
        
        userImageView.layer.cornerRadius = 5
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        
    }
    
    
    
    
    
}
