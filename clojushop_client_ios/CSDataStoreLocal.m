//
//  CSDataProviderCD.m
//  clojushop_client_ios
//
//  Created by ischuetz on 28/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSDataStoreLocal.h"
#import "CSProductCD.h"
//#import "CSProduct.h"
#import <clojushop_client_ios-Swift.h>

@implementation CSDataStoreLocal {
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

//TODO async

+ (CSDataStoreLocal *)sharedDataStoreLocal {
    static CSDataStoreLocal *sharedDataStoreLocal = nil;
    if (!sharedDataStoreLocal) {
        sharedDataStoreLocal = [[super allocWithZone:nil] init];
    }
    return sharedDataStoreLocal;
}


- (id)init {
    self = [super init];
    if (self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        [context setUndoManager:nil];
    }
    
    return self;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void)saveChanges {
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
}



- (void)getProducts: (int) start size: (int) size successHandler: (void (^)(NSArray *products)) successHandler failureHandler: (void (^)()) failureHandler {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [[model entitiesByName] objectForKey:@"CSProductCD"];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"ordering" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Fetch failed, reason: %@", [error localizedDescription]);
        failureHandler();
    }
    
    successHandler(result);
}


- (void)clearProducts {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CSProductCD" inManagedObjectContext:context]];
    NSArray * result = [context executeFetchRequest:request error:nil];
    for (id productCD in result) {
        [context deleteObject:productCD];
    }
}

- (void)saveProducts: (NSArray *)products {
    for (int i = 0; i < products.count; i++) {
        Product *product = [products objectAtIndex:i];
        [self saveProduct:product ordering:i + 1];
    }
    
    [self saveChanges];
}

- (void)saveProduct: (Product *)product ordering:(double)ordering {
    CSProductCD *productCD = [NSEntityDescription insertNewObjectForEntityForName:@"CSProductCD" inManagedObjectContext:context];
    productCD.id = product.id;
    productCD.name = product.name;
    productCD.descr = product.descr;
    productCD.price = product.price;
    productCD.currency = product.currency;
    productCD.seller = product.seller;
    productCD.img_pl = product.imgList;
    productCD.img_pd = product.imgDetails;
    productCD.ordering = ordering;
}


@end
