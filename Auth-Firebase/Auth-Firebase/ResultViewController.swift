import UIKit
import FirebaseAuth

class ResultViewController: UIViewController {
    
    @IBAction func pressedBtnExit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        do {
            try Auth.auth().signOut()
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
