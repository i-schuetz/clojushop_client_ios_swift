//
//  CSCurrencyManager.h
//  clojushop_client_ios
//
//  Created by ischuetz on 29/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CSProduct.h"

@interface CSCurrencyManager : NSObject

+ (CSCurrencyManager *)sharedCurrencyManager;

- (NSString *) getFormattedPrice: (NSString *)price currencyId:(NSString *)currencyId;

@end
