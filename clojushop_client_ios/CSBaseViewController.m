//
//  CSBaseViewController.m
//  clojushop_client
//
//  Created by ischuetz on 24/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSProgressIndicator.h"

@interface CSBaseViewController ()

@end

@implementation CSBaseViewController {
    CSProgressIndicator *opaqueIndicator;
    CSProgressIndicator *transparentIndicator;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initProgressIndicator];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initProgressIndicator {
    opaqueIndicator = [[CSProgressIndicator alloc] initWithFrame: [self getProgressBarBounds] backgroundColor:[UIColor whiteColor]];
    transparentIndicator = [[CSProgressIndicator alloc] initWithFrame: [self getProgressBarBounds] backgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:opaqueIndicator];
    [self.view addSubview:transparentIndicator];

    [self setProgressHidden:YES transparent:YES];
    [self setProgressHidden:YES transparent:NO];
}

/**
 This toggles visibility of a progress bar with transparent or opaque background
 When hiding, it's important to use the same transparency parameter as used to show, to clear the state correctly
 */
- (void)setProgressHidden: (BOOL)hidden transparent: (BOOL)transparent {
    CSProgressIndicator *indicator;
    if (transparent) {
        indicator = transparentIndicator;
    } else {
        indicator = opaqueIndicator;
    }
    
    [indicator setHidden: hidden];
}

/**
 This toggles visibility of a progress bar with an opaque background
 For a transparent background, use (void)setProgressHidden: (BOOL)hidden transparent: (BOOL)transparent
 */
- (void)setProgressHidden: (BOOL)hidden {
    [self setProgressHidden:hidden transparent:NO];
}

- (CGRect)getProgressBarBounds {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    CGSize viewSize =  self.tabBarController.view.frame.size;
    CGSize tabBarSize = self.tabBarController.tabBar.frame.size;
    
    bounds.size.height = viewSize.height - tabBarSize.height;
    
    return bounds;
}

- (BOOL)shouldAutorotate {
    return YES; //iOS 5- compatibility
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
