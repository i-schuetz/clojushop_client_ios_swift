//
//  CSProductsListViewController.m
//  clojushop_client
//
//  Created by ischuetz on 16/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSProductsListViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "CSProductCell.h"
#import "CSProductDetailsViewController.h"
#import "CSDataStore.h"
#import "CSCurrencyManager.h"
#import "UIImageView+AFNetworking.h"
#import <clojushop_client_ios-Swift.h>

@interface CSProductsListViewController ()

@end

@implementation CSProductsListViewController {
    NSArray *products;
}

@synthesize tableView;
@synthesize detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Clojushop client";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *productCellNib = [UINib nibWithNibName:@"CSProductCell" bundle:nil];
    
    [tableView registerNib:productCellNib forCellReuseIdentifier:@"CSProductCell"];
    
    [self requestProducts];
}

- (void)viewDidAppear:(BOOL)animated {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:animated];

    [super viewDidAppear: animated];
}

- (void)requestProducts {
    
    [self setProgressHidden: NO];
    
    [[CSDataStore sharedDataStore] getProducts:0 size:5 successHandler:^(NSArray *products) {
        [self onRetrievedProducts: products];
        
        [self setProgressHidden: YES];
        
        
    } failureHandler:^{
    }];
}
  
- (void)onRetrievedProducts:(NSArray *)prods {
    products = prods;
    [tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CSProductCell";
    CSProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Product *product = [products objectAtIndex:[indexPath row]];
    
    [[cell productName] setText:[product name]];
    [[cell productDescr] setText:[product descr]];
    [[cell productBrand] setText:[product seller]];
    
    
    [[cell productPrice] setText:[[CSCurrencyManager sharedCurrencyManager] getFormattedPrice:product.price currencyId:product.currency]];
    
    [[cell productImg] setImageWithURL:[NSURL URLWithString:[product imgList]]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Product *product = [products objectAtIndex:[indexPath row]];
    
    if (![self splitViewController]) {
        
        CSProductDetailsViewController *detailViewController = [[CSProductDetailsViewController alloc] initWithNibName:@"CSProductDetailsViewController" bundle:nil];
        [detailViewController setProduct: product];
        [detailViewController listViewController:self handleObject:product];
        [self.navigationController pushViewController:detailViewController animated:YES];

    } else {
        [detailViewController listViewController:self handleObject:product];
    }
}


- (void)transferBarButtonToViewController:(UIViewController *)vc {
    // Get the navigation controller in the detail spot of the split view controller
    UINavigationController *nvc = [[[self splitViewController] viewControllers]
                                   objectAtIndex:1];
    
    // Get the root view controller out of that nav controller
    UIViewController *currentVC = [[nvc viewControllers] objectAtIndex:0];
    
    // If it's the same view controller, let's not do anything
    if (vc == currentVC)
        return;
    
    // Get that view controller's navigation item
    UINavigationItem *currentVCItem = [currentVC navigationItem];
    
    // Tell new view controller to use left bar button item of current nav item
    [[vc navigationItem] setLeftBarButtonItem:[currentVCItem leftBarButtonItem]];
    
    // Remove the bar button item from the current view controller's nav item
    [currentVCItem setLeftBarButtonItem:nil];
}


@end
