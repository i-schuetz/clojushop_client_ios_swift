//
//  CSCartItem.h
//  clojushop_client
//
//  Created by ischuetz on 22/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCartItem : NSObject

//TODO store nummeric values as numbers

@property (nonatomic, strong) NSString *id_;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *imgList;
@property (nonatomic, strong) NSString *imgDetails;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString * currency;

+ (CSCartItem *) createFromDict:(NSDictionary *)dict;

@end
