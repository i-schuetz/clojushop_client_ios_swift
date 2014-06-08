//
//  LoginViewController.swift
//  clojushop_client_ios
//
//  Created by ischuetz on 07/06/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

import Foundation

class LoginRegisterViewController:BaseViewController {
    
    @IBOutlet var loginNameField:UITextField
    @IBOutlet var loginPWField:UITextField
    @IBOutlet var loginRegisterView:UIView
    @IBOutlet var userAccountView:UIView
    @IBOutlet var containerView:UIView
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "Login / Register"
    }
    
    func fillWithTestData() {
        loginNameField.text = "user1"
        loginPWField.text = "test123"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillWithTestData()
        
        userAccountView.hidden = true
        loginRegisterView.hidden = false
        
        let tap:UIGestureRecognizer = UIGestureRecognizer(target: self, action: "dismissKeyboard:")
        
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        loginNameField.resignFirstResponder()
        loginPWField.resignFirstResponder()
    }
  
    @IBAction func login(sender : UIButton) {
        let loginName:String = loginNameField.text
        let loginPW:String = loginPWField.text

        self.setProgressHidden(false)
        
        CSDataStore.sharedDataStore().login(loginName, password: loginPW, successHandler: {() -> Void in

            self.setProgressHidden(true)
            self.replaceWithAccountTab()
            
            }, failureHandler: {() -> Void in }) //TODO shorthand for empty closure?
    }
    
    @IBAction func register(sender : UIButton) {
        let registerController:CSRegisterViewController = CSRegisterViewController()
        self.navigationController.pushViewController(registerController, animated: true)
    }
        
    func replaceWithAccountTab() {
//        let accountController: CSUserAccountViewController = CSUserAccountViewController(nibName: CSUserAccountViewController) //TODO nib necessary here?
        let accountController: CSUserAccountViewController = CSUserAccountViewController()
        self.navigationController.tabBarItem.title = "User account"
        self.navigationController.pushViewController(accountController, animated: true)
        self.navigationController.navigationBarHidden = true
    }
    
    
}