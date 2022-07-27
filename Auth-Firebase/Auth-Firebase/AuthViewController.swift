import UIKit
import DeviceKit
import FirebaseAuth
import GoogleSignIn
import Firebase
import LocalAuthentication


class AuthViewController: UIViewController, UITextFieldDelegate {
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            
        }
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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if passwordField.isTouchInside, let login = loginField.text, !loginField.text!.isEmpty,
            let password = passwordField.text, !passwordField.text!.isEmpty  {
            Auth.auth().signIn(withEmail: login, password: password, completion: {
                result, error in
                guard error == nil else {
                    if let err = AuthErrorCode.Code(rawValue: error!._code) {
                        switch err {
                        case .userNotFound:
                            self.showCreateAccount(email: login, password: password)
                        case .invalidEmail:
                            self.showAlert(message: "При входе в систему указаны неверные email и/или пароль")
                        case .wrongPassword:
                            self.showAlert(message: "При входе в систему указаны неверные email и/или пароль")
                        default:
                            self.showAlert(message: "Unexpected error: \(err.rawValue)")
                        }
                    }
                    return
                }
                self.performSegue(withIdentifier: "goToNotes", sender: self)
                self.loginField.text?.removeAll()
                self.passwordField.text?.removeAll()
            })
        }
        else {
            print("Отсутствуют необходимые данные для входа")
        }
        return true
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Создать аккаунт", message: "Хотели ли бы Вы создать аккаунт?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { _ in
            
            Auth.auth().createUser(withEmail: email, password: password, completion: {
                result, error in
                guard error == nil else {
                    self.showAlert(message: (error?.localizedDescription)!)
                    print("Не удалось создать аккаунт")
                    return
                }
                self.performSegue(withIdentifier: "goToNotes", sender: self)
                self.loginField.text?.removeAll()
                self.passwordField.text?.removeAll()
            })
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    @IBAction func pressedBtnEnter(_ sender: UIButton) {
        textFieldShouldReturn(passwordField)
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
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") {
                (succes, error) in
                if succes {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goToNotes", sender: self)
                    }
                }
                else {
                    guard let error = error else {
                        return
                    }
                    print(error.localizedDescription)
                }
            }
        }
        //print("biometry")
    }
    
    @IBAction func pressedBtnGoogle(_ sender: UIButton) {
        guard let clientId = FirebaseApp.app()?.options.clientID else {
            return
        }
        let signInConfig = GIDConfiguration.init(clientID: clientId)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard user != nil else {
                print(error?.localizedDescription as Any)
                return
            }
            self.performSegue(withIdentifier: "goToNotes", sender: self)
        }
    }
}

