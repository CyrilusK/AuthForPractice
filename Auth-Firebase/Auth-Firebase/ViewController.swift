import UIKit
import DeviceKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var btnBiometry: UIButton!
    
    var btnEye = UIButton(type: .custom)
    var btnMail = UIButton(type: .custom)
    var btnLock = UIButton(type: .custom)
    let curDevice = Device.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageForBtnBiometry()
        loginField.delegate = self
        passwordField.delegate = self
        
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
    
    func setImageForBtnBiometry() -> Void {
        let arrModelsSupportFaceid: [Device] = [.iPhone13ProMax,
                                                .iPhone13Pro,
                                                .iPhone13Mini,
                                                .iPhone13,
                                                .iPhone12ProMax,
                                                .iPhone12Pro,
                                                .iPhone12Mini,
                                                .iPhone12,
                                                .iPhone11ProMax,
                                                .iPhone11Pro,
                                                .iPhone11,
                                                .iPhoneXSMax,
                                                .iPhoneXS,
                                                .iPhoneXR,
                                                .iPhoneX,
                                                .simulator(.iPhone13ProMax),
                                                .simulator(.iPhone13Pro),
                                                .simulator(.iPhone13Mini),
                                                .simulator(.iPhone13),
                                                .simulator(.iPhone12ProMax),
                                                .simulator(.iPhone12Pro),
                                                .simulator(.iPhone12Mini),
                                                .simulator(.iPhone12),
                                                .simulator(.iPhone11ProMax),
                                                .simulator(.iPhone11Pro),
                                                .simulator(.iPhone11),
                                                .simulator(.iPhoneXSMax),
                                                .simulator(.iPhoneXS),
                                                .simulator(.iPhoneXR),
                                                .simulator(.iPhoneX),]
        let arrModelsSupportTouchid: [Device] = [.iPhone6s,
                                                 .iPhone6sPlus,
                                                 .iPhone7,
                                                 .iPhone7Plus,
                                                 .iPhone8,
                                                 .iPhone8Plus,
                                                 .iPhoneSE,
                                                 .simulator(.iPhone6s),
                                                 .simulator(.iPhone6sPlus),
                                                 .simulator(.iPhone7),
                                                 .simulator(.iPhone7Plus),
                                                 .simulator(.iPhone8),
                                                 .simulator(.iPhone8Plus),
                                                 .simulator(.iPhoneSE) ]
        let device = Device.current
         
        if device.isOneOf(arrModelsSupportFaceid) {
            btnBiometry.configuration?.background.image = UIImage(systemName: "faceid")
            btnBiometry.configuration?.background.imageContentMode = .scaleAspectFit
            
        }
        else if device.isOneOf(arrModelsSupportTouchid) {
            btnBiometry.configuration?.background.image = UIImage(systemName: "touchid")
            btnBiometry.configuration?.background.imageContentMode = .scaleAspectFit
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if passwordField.isTouchInside && !passwordField.text!.isEmpty && !loginField.text!.isEmpty {
            self.performSegue(withIdentifier: "goToNotes", sender: self)
        }
        return true
    }
    
    @IBAction func pressedBtnEnter(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToNotes", sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 0.5
        }
        else {
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 0.1
        }
    }
    
    @IBAction func pressedBtnBiometry(_ sender: UIButton) {
        //print("biometry")
    }
    
    @IBAction func pressedBtnGoogle(_ sender: UIButton) {
        //print("google")
    }
    
}

