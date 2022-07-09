import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    
    var btnEye = UIButton(type: .custom)
    var btnMail = UIButton(type: .custom)
    var btnLock = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnEye.setImage(UIImage(systemName: "eye"), for: .normal)
        btnEye.tintColor = UIColor(named: "colorForBtns")
        btnEye.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        passwordField.rightView = btnEye
        passwordField.rightViewMode = .always
        
        btnLock.setImage(UIImage(systemName: "lock"), for: .normal)
        btnLock.tintColor = UIColor(named: "colorForBtns")
        passwordField.leftView = btnLock
        passwordField.leftViewMode = .always
        
        btnMail.setImage(UIImage(systemName: "envelope.badge.shield.half.filled"), for: .normal)
        btnMail.tintColor = UIColor(named: "colorForBtns")
        loginField.leftView = btnMail
        loginField.leftViewMode = .always
    }

    @IBAction func refresh(_ sender: UIButton) {
        if passwordField.isSecureTextEntry {
            btnEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordField.isSecureTextEntry = false
        } else {
            btnEye.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordField.isSecureTextEntry = true
        }
    }

}

