//
//  DialogUtils.swift
//  clojushop_client_ios
//
//  Created by ischuetz on 09/06/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

import Foundation

@objc
class DialogUtils {
    
    class func showAlert(title:String, msg:String) {
        let alert:UIAlertView = UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
}