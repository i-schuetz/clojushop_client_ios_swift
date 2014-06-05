//
//  CSSingleSelectionController.m
//  clojushop_client_ios
//
//  Created by ischuetz on 27/05/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

#import "CSSingleSelectionController.h"

@interface CSSingleSelectionController ()

@end

@implementation CSSingleSelectionController

@synthesize delegate;
@synthesize items;
@synthesize baseObject;

-(id)initWithStyle:(UITableViewStyle)style
{
    if ([super initWithStyle:style] != nil) {
    }
    return self;
}

-(void)viewDidLoad {
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[items objectAtIndex:indexPath.row] getLabel];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<CSSingleSelectionItem> selectedItem = [items objectAtIndex:indexPath.row];
    
    if (delegate != nil) {
        [delegate selectedItem:selectedItem baseObject:baseObject];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
