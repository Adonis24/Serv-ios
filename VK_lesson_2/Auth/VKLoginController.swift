//
//  ViewController.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 02/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit
//import Firebase


class VKLoginController: UIViewController {
    var delay: CFTimeInterval = 0.4
  //  private var handle: AuthStateDidChangeListenerHandle!
    @IBOutlet weak var loadStackView: UIStackView!
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    
    @IBOutlet weak var loadView_1: LoadView!
    @IBOutlet weak var loadView_2: LoadView!
    @IBOutlet weak var loadView_3: LoadView!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверяем данные
        let checkResult = checkUserData()
        
        // Если данные неверны, покажем ошибку
        if !checkResult {
            showLoginError()
        }
        
        // Вернем результат
        return checkResult
    }
    
    @IBAction func exitButtom(_ sender: Any) {
     // exit(0)
//        if let exit = navigationController {
//            exit.popViewController(animated: true)
//            do {
//                // 1
//                //try Auth.auth().signOut()
//                self.dismiss(animated: true, completion: nil)
//            } catch (let error) {
//                // 2
//                print("Auth sign out failed: \(error)")
//            }
//
//        } else {
            dismiss(animated: true, completion: nil)
        //}
    }
    
   
    
    @IBAction func signUp(_ sender: UIButton) {
        
        
        // 1
//        let alert = UIAlertController(title: "Register",
//                                      message: "Register",
//                                      preferredStyle: .alert)
//        // 2
//        alert.addTextField { textEmail in
//            textEmail.placeholder = "Enter your email"
//        }
//        alert.addTextField { textPassword in
//            textPassword.isSecureTextEntry = true
//            textPassword.placeholder = "Enter your password"
//        }
//        // 3
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .cancel)
//
//        // 4
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//            // 4.1
//            guard let emailField = alert.textFields?[0],
//                let passwordField = alert.textFields?[1],
//                let password = passwordField.text,
//                let email = emailField.text else { return }
//            // 4.2
//            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
//                if let error = error {
//                    self?.showAlert(title: "Error", message: error.localizedDescription)
//                } else {
//                    // 4.3
//                    Auth.auth().signIn(withEmail: email, password: password)
//                }
//            }
//        }
//        // 5
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true, completion: nil)
//

    }
    func checkUserData() -> Bool {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    func showAlert(title: String,message: String)
    {
        let alertVK = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alertVK.addAction(action)
        // Показываем UIAlertController
        present(alertVK, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        

 
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Adding authorization status listener
//        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                self.performSegue(withIdentifier: "Log In", sender: nil)
//                self.loginInput.text = nil
//                self.passwordInput.text = nil
//            }
//        }

        
    }
    override func viewDidAppear(_ animated: Bool) {
        
       // for index in 1...loadStackView.arrangedSubviews.count {
        let st = [loadView_1,loadView_2,loadView_3]
        for view in st {
            if  let currentView = view{//loadStackView.arrangedSubviews[index]
                UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse,.repeat], animations: {
                    self.manageOpacity(currentView, delay: CFTimeInterval(self.delay))}, completion: nil)
            
            }
            self.delay += 0.1
        }
         self.delay = 0
        
     //   Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func manageOpacity(_ sender: UIView, delay: CFTimeInterval)
    {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.beginTime = CACurrentMediaTime()
        animation.toValue = 0
        animation.fromValue = 1
        animation.duration = 0.7
        animation.fillMode = .removed
        animation.autoreverses = true
        animation.repeatCount = .infinity
        sender.layer.add(animation,forKey: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification,object:nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification,object:nil)
         //   Auth.auth().removeStateDidChangeListener(handle)
    }
    
    
    //Keyboard disappear
    @objc func keyboardWillBeHidden(notification:Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard(){
        self.scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification){
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top:0.0,left:0.0,bottom:kbSize.height,right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    
}




