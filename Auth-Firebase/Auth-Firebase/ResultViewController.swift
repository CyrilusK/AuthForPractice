import UIKit
import FirebaseAuth
import GoogleSignIn

class ResultViewController: UIViewController {
    
    @IBAction func pressedBtnExit(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            print("log out")
        } catch let signOutError as NSError {
        self.showAlert(message: signOutError.localizedDescription)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
