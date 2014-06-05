//
//  CSDialogUtils.m
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSDialogUtils.h"

@interface CSDialogUtils ()

@end

@implementation CSDialogUtils

+ (void)showAlert: (NSString *) title msg: (NSString *) msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}


@end