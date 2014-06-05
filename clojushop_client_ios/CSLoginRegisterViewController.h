//
//  CSLoginRegisterViewController.h
//  clojushop_client
//
//  Created by ischuetz on 23/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseViewController.h"

@interface CSLoginRegisterViewController : CSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *loginNameField;
@property (weak, nonatomic) IBOutlet UITextField *loginPWField;

@property (weak, nonatomic) IBOutlet UIView *loginRegisterView;

//TODO custom subviews
@property (weak, nonatomic) IBOutlet UIView *userAccountView;

@property (weak, nonatomic) IBOutlet UIView *containerView;


- (IBAction)login:(id)sender;
- (IBAction)register:(id)sender;

@end