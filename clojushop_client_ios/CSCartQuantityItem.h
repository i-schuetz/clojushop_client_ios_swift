//
//  CSCartQuantityItem.h
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSSingleSelectionItem.h"
#import "CSCartItem.h"

@interface CSCartQuantityItem : NSObject <CSSingleSelectionItem>

@property (nonatomic, strong) NSString *quantity;

- initWithQuantity: (CSCartItem *)cartItem;
- (id)getWrappedItem;

@end
