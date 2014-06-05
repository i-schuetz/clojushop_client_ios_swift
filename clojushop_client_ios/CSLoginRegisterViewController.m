//
//  CSLoginRegisterViewController.m
//  clojushop_client
//
//  Created by ischuetz on 23/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSLoginRegisterViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "CSDataStore.h"
#import "CSRegisterViewController.h"
#import "CSUserAccountViewController.h"

@interface CSLoginRegisterViewController ()

@end

@implementation CSLoginRegisterViewController

@synthesize loginNameField;
@synthesize loginPWField;
@synthesize loginRegisterView;
@synthesize userAccountView;
@synthesize containerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Login / Register"];
    }
    return self;
}

- (void)fillWithTestData {
    [loginNameField setText:@"user1"];
    [loginPWField setText:@"test123"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self fillWithTestData];
    
    [userAccountView setHidden:YES];
    [loginRegisterView setHidden:NO];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"test");
}

-(void)dismissKeyboard {
    [loginNameField resignFirstResponder];
    [loginPWField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//todo callback onlogin, and method login which accept name, pw parameters
- (IBAction)login:(id)sender {
    NSString *loginName = [loginNameField text];
    NSString *loginPW = [loginPWField text];

    [self setProgressHidden: NO];

    [[CSDataStore sharedDataStore] login: loginName password: loginPW
        successHandler:^{

            [self setProgressHidden: YES];

            [self replaceWithUserAccountTab];
            
            //[self returnToPreviousTab];
            
        } failureHandler:^{
            [self setProgressHidden: YES];

        }];
}

- (void) replaceWithUserAccountTab {
    CSUserAccountViewController *accountController = [[CSUserAccountViewController alloc] initWithNibName:@"CSUserAccountViewController" bundle:nil];
    [[self navigationController].tabBarItem setTitle:@"User account"];

    [self.navigationController pushViewController:accountController animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES];

    
//    UIViewController* userAccountViewController = [[CSUserAccountViewController alloc] init];
//    
//    int tabIndex = 2;
//    NSMutableArray *tabbarViewControllers = [self.tabBarController.viewControllers mutableCopy];
//    [tabbarViewControllers replaceObjectAtIndex:tabIndex withObject:userAccountViewController];
//    self.tabBarController.viewControllers = tabbarViewControllers;
    
    
}

- (void) returnToPreviousTab {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    int activeTab = [(NSNumber*)[def objectForKey:@"prevActiveTab"] intValue];
    
    [self.tabBarController setSelectedIndex:activeTab];
    
}

- (IBAction)register:(id)sender {
    CSRegisterViewController *registerController = [[CSRegisterViewController alloc] initWithNibName:@"CSRegisterViewController" bundle:nil];
    
    [self.navigationController pushViewController:registerController animated:YES];
}
@end