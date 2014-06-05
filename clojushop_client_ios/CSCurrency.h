//
//  CSCurrency.h
//  clojushop_client_ios
//
//  Created by ischuetz on 29/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCurrency : NSObject

@property (nonatomic) int id;
@property (nonatomic, strong) NSString *format;

- (id)initWithId: (int)id format:(NSString*)format;

@end
