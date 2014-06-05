//
//  CSCartViewController.h
//  clojushop_client
//
//  Created by ischuetz on 23/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseViewController.h"
#import "CSSingleSelectionController.h"

@interface CSCartViewController : CSBaseViewController <CSSingleSelectionControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *emptyCartView;

@property (weak, nonatomic) IBOutlet UIView *totalContainer;
@property (weak, nonatomic) IBOutlet UIView *buyView;
@property (weak, nonatomic) IBOutlet UILabel *totalView;

- (IBAction)onBuyPress:(id)sender;

@property (nonatomic, strong) CSSingleSelectionController *quantityPicker;
@property (nonatomic, strong) UIPopoverController *quantityPickerPopover;

- (void)setQuantity:(id)sender atIndexPath:(NSIndexPath *)ip;

@end
