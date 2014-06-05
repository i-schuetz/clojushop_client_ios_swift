//
//  CSPaymentViewController.m
//  clojushop_client_ios
//
//  Created by ischuetz on 30/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSPaymentViewController.h"
#import "MBProgressHUD.h"
#import "CSDialogUtils.h"
#import "CSDataStore.h"

#define EXAMPLE_STRIPE_PUBLISHABLE_KEY @"pk_test_6pRNASCoBOKtIshFeQd4XMUh"

@implementation CSPaymentViewController

@synthesize totalValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Card";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Setup checkout
    self.checkoutView = [[STPView alloc] initWithFrame:CGRectMake(15,20,290,55) andKey:EXAMPLE_STRIPE_PUBLISHABLE_KEY];
    self.checkoutView.delegate = self;
    [self.view addSubview:self.checkoutView];
}

- (void)stripeView:(STPView *)view withCard:(PKCard *)card isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (IBAction)save:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.checkoutView createToken:^(STPToken *token, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (error) {
            [self hasError:error];
        } else {
            [self hasToken:token];
        }
    }];
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token {
    NSLog(@"Received token %@", token.tokenId);
    
    [[CSDataStore sharedDataStore] pay:token.tokenId value:[totalValue stringValue] currency:@"eur" successHandler:^{
        
        //on payment success the cart is cleared in the server
        //we send notification to clear local cart
        //we currently store it only in memory - otherwise need new method in DataStore and DataStoreLocal to clear in db
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearLocalCart" object:nil];

        
        [self.navigationController popViewControllerAnimated:YES];

    } failureHandler:^{
        [CSDialogUtils showAlert:@"Error" msg:@"Error ocurred processing payment"];
    }];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://example.com"]];
//    request.HTTPMethod = @"POST";
//    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@", token.tokenId];
//    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               [MBProgressHUD hideHUDForView:self.view animated:YES];
//                               
//                               //                               if (error) {
//                               //                                   [self hasError:error];
//                               //                               } else {
//                               [self.navigationController popViewControllerAnimated:YES];
//                               //                               }
//                           }];
}

@end