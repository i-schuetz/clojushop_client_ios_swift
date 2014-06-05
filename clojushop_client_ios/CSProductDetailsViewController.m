//
//  CSProductDetailsViewController.m
//  clojushop_client
//
//  Created by ischuetz on 20/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSProductDetailsViewController.h"
#import "CSDataStore.h"
#import "CSDialogUtils.h"
#import "CSCurrencyManager.h"
#import "CSProductsListViewController.h"
#import "UIImageView+AFNetworking.h"

@interface CSProductDetailsViewController ()

@end

@implementation CSProductDetailsViewController

@synthesize product;
@synthesize pleaseSelectView;

//@synthesize product = product_;
@synthesize productNameLabel, productBrandLabel, productPriceLabel, productImageView, productLongDescrLabel, containerVIew;

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc {
    [barButtonItem setTitle:@"List"];
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
}

- (void)listViewController:(CSProductsListViewController *)lvc handleObject:(id)object {
    Product *product = object;
    self.product = product;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self initViews];
    }
}


- (void)initViews {
    [pleaseSelectView setHidden:YES];
    
    self.title = [product name];

    [productNameLabel setText:[product name]];
    [productBrandLabel setText:[product seller]];
    [productLongDescrLabel setText:[product descr]]; //todo
    
    [productPriceLabel setText:[[CSCurrencyManager sharedCurrencyManager] getFormattedPrice:product.price currencyId:product.currency]];
    
    [productImageView setImageWithURL:[NSURL URLWithString:[product imgDetails]]];
}

//TODO review this
- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button {
    
    // Remove the bar button item from our navigation item
    // We'll double check that its the correct button, even though we know it is
    if (button == [[self navigationItem] leftBarButtonItem])
        [[self navigationItem] setLeftBarButtonItem:nil];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    //If in portrait mode, display the master view TODO check also ipad
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [self.navigationItem.leftBarButtonItem.target performSelector:self.navigationItem.leftBarButtonItem.action withObject:self.navigationItem];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self initViews];
    } else {
        [pleaseSelectView setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}




- (IBAction)onAddToCartPress:(id)sender {
    [[CSDataStore sharedDataStore] addToCart:[product id] successHandler:^{
        
        [CSDialogUtils showAlert: @"Success" msg: @"Added!"];

    } failureHandler:^{
    }];
}

@end
