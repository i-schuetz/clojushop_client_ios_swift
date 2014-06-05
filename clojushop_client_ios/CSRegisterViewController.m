//
//  CSRegisterViewController.m
//  clojushop_client
//
//  Created by ischuetz on 23/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSRegisterViewController.h"
#import "CSDataStore.h"

@interface CSRegisterViewController ()

@end

@implementation CSRegisterViewController

@synthesize usernameField;
@synthesize emailField;
@synthesize passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)fillWithTestData {
    [usernameField setText:@"user2"];
    [emailField setText:@"user2@bla.com"];
    [passwordField setText:@"test123"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
//    [self fillWithTestData];
}

-(void)dismissKeyboard {
    [usernameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRegisterPress:(id)sender {
    NSString *username = [usernameField text];
    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    
    [self setProgressHidden: NO];

    [[CSDataStore sharedDataStore] register: username email: email password: password
                              successHandler:^{
                                  
                                  [self setProgressHidden: YES];

                                  [self.navigationController popToRootViewControllerAnimated:YES];

                              } failureHandler:^{
                                  [self setProgressHidden: YES];
                              }];
    
}

@end