//
//  CSCurrency.m
//  clojushop_client_ios
//
//  Created by ischuetz on 29/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSCurrency.h"

@implementation CSCurrency

- (id)initWithId: (int)id format:(NSString*)format {
    self = [super init];
    if (self) {
        [self setId:id];
        [self setFormat:format];
    }
    return self;
}

@end
