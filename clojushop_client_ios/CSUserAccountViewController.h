//
//  CSBaseViewController.h
//  clojushop_client
//
//  Created by ischuetz on 23/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseViewController.h"

@interface CSUserAccountViewController : CSBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *emailField;

- (IBAction)onLogoutPress:(id)sender;

@end
