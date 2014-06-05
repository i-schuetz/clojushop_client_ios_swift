//
//  CSCartViewController.m
//  clojushop_client
//
//  Created by ischuetz on 23/04/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSCartViewController.h"
#import "CSDataStore.h"
#import "CSCartItem.h"
#import "CSCartItemCell.h"
#import "CSCartQuantityItem.h"
#import "CSCurrencyManager.h"
#import "CSDialogUtils.h"
#import "CSPaymentViewController.h"
#import "UIImageView+AFNetworking.h"

@interface CSCartViewController ()

@end

@implementation CSCartViewController {
    NSMutableArray *items;
    BOOL showingController; //quickfix to avoid reloading when coming back from quantity controller... needs correct implementation
    CSCurrency *userCurrency;
}

@synthesize emptyCartView;
@synthesize totalView;
@synthesize totalContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cart";
        
        // listen for notifications - add to view controller doing the actions
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCart) name:@"ClearLocalCart" object:nil];

    }
    return self;
}

- (void)clearCart {
    [items removeAllObjects];
    [[self tableView] reloadData];
}

- (void) onRetrievedItems: (NSArray *) i {
    items = i;
    
    if ([items count] == 0) {
        //TODO why this didnt work with only nib - before there was view with children table and empty, empty never shows
//        [[[[self tableView] superview] superview] addSubview: emptyCartView];

        [self showCartState:YES];

    } else {
        [self showCartState:NO];
        [[self tableView] reloadData];
        [self onModifyLocalCartContent];
    }
}

- (void)showCartState: (BOOL) empty {
    if (empty) {
        [emptyCartView setHidden:NO];
        
    } else {
        [emptyCartView setHidden:YES];
    }
}

- (void)onModifyLocalCartContent {
    if ([items count] == 0) {
        [totalView setText: @"0"]; //just for consistency
        
        [self showCartState:YES];
        
        //TODO why this didnt work with only nib - before there was view with children table and empty, empty never shows
        [[[[self tableView] superview] superview] addSubview:[self emptyCartView]];
        
    } else {
        //TODO server calculates this
        //TODO multiple currencies
        //for now we assume all the items have the same currency
        NSString *currencyId = ((CSCartItem *)[items objectAtIndex:0]).currency;
        [totalView setText:
         [[CSCurrencyManager sharedCurrencyManager] getFormattedPrice: [self getTotalPrice:items].stringValue currencyId:currencyId]];

        [self showCartState:NO];
        [[self tableView] reloadData];
    }
}


- (NSNumber *)getTotalPrice:(NSArray *)cartItems {
    double total = 0;
    for (CSCartItem *item in cartItems) {
        total += [item.price doubleValue] * item.quantity.intValue;
    }
    return [NSNumber numberWithDouble:total];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *nib = [UINib nibWithNibName:@"CSCartItemCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"CSCartItemCell"];

    [emptyCartView setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!showingController) {
        [self requestItems];
    }
    showingController = false;

    [self adjustLayout];
}

- (void) requestItems {
    [self setProgressHidden: NO transparent:NO];
    
    [[CSDataStore sharedDataStore] getCart:^(NSArray *items) {
        [self setProgressHidden: YES transparent:NO];
        
        [self onRetrievedItems: items];
        
    } failureHandler:^{
        [self setProgressHidden: YES transparent:NO];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

//TODO implement this correctly...
- (void)adjustLayout {
    
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.toolbar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
    
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    float h = screenBounds.size.height - (CGRectGetHeight(self.tabBarController.tabBar.frame)
                                                  + CGRectGetHeight(self.navigationController.navigationBar.frame)
                                                  + CGRectGetHeight(self.buyView.frame)
                                                  );
    
    [self.tableView setFrame: CGRectMake(0, CGRectGetHeight(self.buyView.frame), self.tableView.frame.size.width, h)]
    ;
    //    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight(self.tabBarController.tabBar.frame) + CGRectGetHeight(self.buyView.frame), 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSCartItemCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    CSCartItem *item = [items objectAtIndex:[indexPath row]];
    
    [[cell productName] setText:[item name]];
    [[cell productDescr] setText:[item descr]];
    [[cell productBrand] setText:[item seller]];
    
    [[cell productPrice] setText:[[CSCurrencyManager sharedCurrencyManager] getFormattedPrice:[item price] currencyId:item.currency]];

    [[cell quantityField] setText:[item quantity]];

    [cell setController:self];
    [cell setTableView:tableView];
    
    [[cell productImg] setImageWithURL:[NSURL URLWithString:[item imgList]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CSCartItem *item = [items objectAtIndex:[indexPath row]];
        
        [[CSDataStore sharedDataStore] removeFromCart:[item id_] successHandler:^{
            [items removeObject:item];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

            [self onModifyLocalCartContent];

        } failureHandler:^{
        }];
    }
}

- (void)setQuantity:(id)sender atIndexPath:(NSIndexPath *)ip {
    CSCartItem *selectedCartItem = [items objectAtIndex:ip.row];
    
    
    //for now dummy quantities, our products don't have stock yet...
    NSArray *quantities = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", nil];
    
    NSArray *cartItemsForQuantitiesDialog = [self wrapQuantityItemsForDialog: quantities];
    CSSingleSelectionController *selectQuantityController = [[CSSingleSelectionController alloc] initWithStyle:UITableViewStylePlain];
    
    selectQuantityController.items = cartItemsForQuantitiesDialog;
    selectQuantityController.delegate = self;
    selectQuantityController.baseObject = selectedCartItem;
    
    showingController = true;
    [self presentViewController:selectQuantityController animated:YES completion:nil];
}


- (NSArray *)wrapQuantityItemsForDialog:(NSArray *)quantities {
    NSMutableArray *wrappedQuantityItems = [[NSMutableArray alloc]init];
    
    for (NSString *quantity in quantities) {
        [wrappedQuantityItems addObject:[[CSCartQuantityItem alloc]initWithQuantity:quantity]];
    }
    return wrappedQuantityItems;
}



-(void)selectedItem:(id<CSSingleSelectionItem>)item baseObject:(id)baseObject {
    CSCartItem *cartItem = baseObject;
    NSString *quantity = [item getWrappedItem];
    
    [self setProgressHidden:NO transparent:YES];
    
    [[CSDataStore sharedDataStore] setCartQuantity: cartItem.id_ quantity:quantity successHandler:^{
        cartItem.quantity = quantity; //TODO server should send updated quantity back
        [[self tableView] reloadData];

        [self onModifyLocalCartContent];
        
        [self setProgressHidden:YES transparent:YES];
    } failureHandler:^{
    }];
}

- (IBAction)onBuyPress:(id)sender {
    CSPaymentViewController *paymentViewController = [[CSPaymentViewController alloc] initWithNibName:@"CSPaymentViewController" bundle:nil];
    paymentViewController.totalValue = [self getTotalPrice:items];

    //TODO
//    paymentViewController.currency = [CSCurrency alloc]initWithId:<#(int)#> format:<#(NSString *)#>;
    
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

@end
