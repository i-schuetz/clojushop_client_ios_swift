//
//  CSCartQuantityItem.m
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSCartQuantityItem.h"
#import "CSCartItem.h"

@implementation CSCartQuantityItem

@synthesize quantity;

- initWithQuantity: (NSString *)quantity {
    self = [super init];
    if (self) {
        self.quantity = quantity;
    }
    return self;
}

- (NSString *)getLabel {
    return self.quantity;
}

- (id)getWrappedItem {
    return quantity;
}

@end