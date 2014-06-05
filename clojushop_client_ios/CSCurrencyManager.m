//
//  CSCurrencyManager.m
//  clojushop_client_ios
//
//  Created by ischuetz on 29/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSCurrencyManager.h"
#import "CSCurrency.h"

@implementation CSCurrencyManager {
    NSDictionary *currencyMap;
}

- (id)init {
    self = [super init];
    if (self) {
        
        //for now this is in the client. At some point server can send it to us in e.g. an initialisation block.
        currencyMap = @{
                        @"1": [[CSCurrency alloc] initWithId:1 format:@"%@ €"],
                        @"2":[[CSCurrency alloc] initWithId:2 format:@"$ %@"]
        };
    }
    return self;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedCurrencyManager];
}

+ (CSCurrencyManager *)sharedCurrencyManager {
    static CSCurrencyManager *sharedCurrencyManager = nil;
    if (!sharedCurrencyManager) {
        sharedCurrencyManager = [[super allocWithZone:nil] init];
        
    }
    return sharedCurrencyManager;
}

- (NSString *) getFormattedPrice: (NSString *)price currencyId:(NSString *)currencyId {
    NSString *currencyFormat = [[currencyMap objectForKey:currencyId] format];
    
    return [NSString stringWithFormat:currencyFormat, price];
}

@end