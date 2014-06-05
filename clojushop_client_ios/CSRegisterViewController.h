//
//  CSRegisterViewController.h
//  clojushop_client
//
//  Created by ischuetz on 23/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseViewController.h"

@interface CSRegisterViewController : CSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)onRegisterPress:(id)sender;

@end