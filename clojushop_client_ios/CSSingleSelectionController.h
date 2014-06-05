//
//  CSSingleSelectionController.h
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSingleSelectionItem.h"


/**
 Displays a table view with a list of strings. When an item is selected, the controller is dismissed,
 and the selected item returned.
 */
@protocol CSSingleSelectionControllerDelegate <NSObject>

@required
- (void)selectedItem:(id<CSSingleSelectionItem>)item baseObject:(id)baseObject;
@end

@interface CSSingleSelectionController : UITableViewController

/**
 The items to be displayed. They must implement CSSingleSelectionItem protocol.
 */
@property (nonatomic, strong) NSArray *items;

/**
 Delegate to be called when an item are selected.
 */
@property (nonatomic, weak) id<CSSingleSelectionControllerDelegate> delegate;

/**
 This is an optional object that can be passed to the dialog and will be passed back
 in selectedItem method. Usually this will be an object from which we are selecting a property,
 for example if our items are sizes of a cart item, the baseObject would be the cartItem to which the sizes belong.
 
 We use this in order to avoid holding additional, temporary instance state in the presenting controller.
 */
@property (nonatomic, strong) id baseObject;

@end
