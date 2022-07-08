import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    let button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(passwordField.frame.size.width - 25), y: CGFloat(10), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        passwordField.rightView = button
        passwordField.rightViewMode = .always
    }

    @IBAction func refresh(_ sender: Any) {
        print("ok")
    }

}

