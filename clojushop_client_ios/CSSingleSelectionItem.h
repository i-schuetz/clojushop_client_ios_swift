//
//  CSSingleSelectionItem.h
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Wrapper for items which will be displayed using CSSingleSelectionController
 */
@protocol CSSingleSelectionItem <NSObject>

@required

/**
 Returns label to be displayed in tableView
 */
- (NSString *)getLabel;

/**
 Returns model object corresponding to label. This is used only to be pased back when the item is selected.
 */
- (id)getWrappedItem;

@end
