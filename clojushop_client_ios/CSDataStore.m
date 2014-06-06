//
//  CSDataProvider.m
//  clojushop_client
//
//  Created by ischuetz on 22/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "CSDataStoreRemote.h"
#import "CSDialogUtils.h"
#import "CSDataStore.h"
#import "CSDataStoreLocal.h"
#import <clojushop_client_ios-Swift.h>

@implementation CSDataStore {
    CSDataStoreRemote *dataStoreRemote;
    CSDataStoreLocal *dataStoreLocal;
}

- (id)init {
    self = [super init];
    if (self) {
        dataStoreRemote = [[CSDataStoreRemote alloc] init];
        dataStoreLocal = [[CSDataStoreLocal alloc] init];
    }
    return self;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedDataStore];
}

+ (CSDataStore *)sharedDataStore {
    static CSDataStore *sharedDataStore = nil;
    if (!sharedDataStore) {
        sharedDataStore = [[super allocWithZone:nil] init];
        
    }
    return sharedDataStore;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//public


- (void)getProducts: (int) start size: (int) size successHandler: (void (^)(NSArray *products)) successHandler failureHandler: (void (^)()) failureHandler {
    
    __block BOOL returnedFromCache = false;
    
    [dataStoreLocal getProducts:start size:size successHandler:^(NSArray *productsCD) {
        if (productsCD.count > 0) { //TODO products can be empty
            NSArray *products = [Product createFromCDs:productsCD];
            successHandler(products);
            
            returnedFromCache = true;
        }
        
        //background update (silent - new data will be available for the next request)
        [dataStoreRemote getProducts:start size:size successHandler:^(NSDictionary *response) {
            
            NSString *md5 = [response objectForKey:@"md5"];
            NSArray *productsJSON = [response objectForKey:@"products"];
            
            //TODO md5
            NSArray *products = [Product createFromDictArray:productsJSON];
            
            [dataStoreLocal clearProducts];
            [dataStoreLocal saveProducts:products];
            
            if (!returnedFromCache) {
                successHandler(products);
            }
            
        } failureHandler:^{
            if (!returnedFromCache) {
                failureHandler();
            }
        }];
    
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)getUser: (void (^)(NSDictionary *user)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote getUser:^(NSDictionary *user) {
        successHandler(user);
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)logout: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote logout:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)login: (NSString *) username password: (NSString *) password successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote login:username password:password successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)register: (NSString *) username email: (NSString *) email password: (NSString *) password successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote register:username email:email password:password successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)addToCart: (NSString *) productId successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote addToCart:productId successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)removeFromCart: (NSString *) productId successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote removeFromCart:productId successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)setCartQuantity: (NSString *) productId quantity: (NSString *) quantity successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote setCartQuantity:productId quantity:quantity successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

- (void)getCart: (void (^)(NSArray *items)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote getCart:^(NSArray *items) {
        successHandler(items);
    } failureHandler:^{
        failureHandler();
    }];
}


- (void)pay: (NSString *) token value: (NSString *) value currency: (NSString *) currency successHandler: (void (^)(void)) successHandler failureHandler: (void (^)()) failureHandler {
    [dataStoreRemote pay:token value:value currency:currency successHandler:^{
        successHandler();
    } failureHandler:^{
        failureHandler();
    }];
}

@end
