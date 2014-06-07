//
//  CSPaymentViewController.h
//  clojushop_client_ios
//
//  Created by ischuetz on 30/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPView.h"
#import <clojushop_client_ios-Swift.h>

@interface CSPaymentViewController : UIViewController<STPViewDelegate>

@property STPView *checkoutView;
@property Currency *currency;
@property NSNumber *totalValue;

@end
