//
//  CSProgressIndicator.m
//  clojushop_client
//
//  Created by ischuetz on 24/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSProgressIndicator.h"

@implementation CSProgressIndicator {
    UIActivityIndicatorView *indicator;
}

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = self.center;
        [self addSubview:indicator];
        [indicator setHidden:NO];
        [indicator bringSubviewToFront:self];
        [indicator startAnimating];
        [self setBackgroundColor:backgroundColor];
    }
    return self;
}


- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
