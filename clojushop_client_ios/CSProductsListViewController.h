//
//  CSProductsListViewController.h
//  clojushop_client
//
//  Created by ischuetz on 16/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseViewController.h"
//#import "CSProductDetailsViewController.h"

@class CSProductDetailsViewController;

@interface CSProductsListViewController : CSBaseViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CSProductDetailsViewController *detailViewController;

@end

// A new protocol named ListViewControllerDelegate
@protocol ListViewControllerDelegate

// Classes that conform to this protocol must implement this method:
- (void)listViewController:(CSProductsListViewController *)lvc handleObject:(id)object;
@end