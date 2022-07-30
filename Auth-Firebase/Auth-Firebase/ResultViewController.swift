import UIKit
import FirebaseAuth
import GoogleSignIn

class ResultViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.borderColor = UIColor(named: "colorForBtns")?.cgColor
        textView.layer.borderWidth = 1
    }
    
    @IBAction func pressedBtnExit(_ sender: UIButton) {
        do {
            //try? AuthController.signOut()
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
