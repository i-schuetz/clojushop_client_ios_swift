//
//  CSCartItemCell.m
//  clojushop_client
//
//  Created by ischuetz on 22/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSCartItemCell.h"

@implementation CSCartItemCell

@synthesize controller;
@synthesize tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onQuantityPress:(id)sender {
//    NSString *selector = NSStringFromSelector(_cmd);
//    selector = [selector stringByAppendingString:@"atIndexPath:"];
    
    SEL selector = NSSelectorFromString(@"setQuantity:atIndexPath:");
    
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:self];
 
    [[self controller] performSelector:selector withObject:sender withObject:indexPath];
}

@end
