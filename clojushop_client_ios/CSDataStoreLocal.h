//
//  CSDataProviderCD.h
//  clojushop_client_ios
//
//  Created by ischuetz on 28/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSDataStoreLocal : NSObject

+ (CSDataStoreLocal *)sharedDataStoreLocal;

- (void)getProducts: (int) start size: (int) size successHandler: (void (^)(NSArray *products)) successHandler failureHandler: (void (^)()) failureHandler;

- (void)clearProducts;
- (void)saveProducts: (NSArray *)products;

@end
