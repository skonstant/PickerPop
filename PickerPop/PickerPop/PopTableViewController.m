//
//  PopTableViewController.m
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//

#import "PopTableViewController.h"
#import "PickerPop.h"

@interface PopTableViewController ()
@property NSArray *data;
@property (copy) TapBlock action;
@end

@implementation PopTableViewController

- (id)initWithData:(NSArray *)data action:(void ( ^ )(NSObject *))predicate
{
    self = [super init];
    if (self) {
        self.data = data;
        self.action = predicate;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.action([self.data objectAtIndex:indexPath.row]);
}

@end
