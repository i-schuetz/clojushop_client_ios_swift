//
//  CSProductCD.h
//  clojushop_client_ios
//
//  Created by ischuetz on 28/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CSProductCD : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * img_pl;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * seller;
@property (nonatomic, retain) NSString * img_pd;
@property (nonatomic) double ordering;


@end
