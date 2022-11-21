
import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logOutButton(_ sender: Any) {
   
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLogin", sender: nil)


        } catch {
            
            print("Çıkış Yapılamadı")
        }
        
    }
    
}
