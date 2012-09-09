//
//  PickerPop.m
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PickerPop.h"
#import "PopTableViewController.h"

@interface PickerPop ()

@property NSArray *data;
@property UIView *initiator;
@property (copy) TapBlock action;
@property UIPopoverController *popover;
@end

@implementation PickerPop

- (id)initWithData:(NSArray *)data initiator:(UIView *)view action:(void ( ^ )(NSObject *))predicate
{
    self = [super init];
    self.data = data;
    self.initiator = view;
    self.action = predicate;
    
    
    PopTableViewController *table = [[PopTableViewController alloc] initWithData:self.data action:^(id selected) {
        [self.popover dismissPopoverAnimated:YES];
        self.action(selected);
    } ];
    self.popover = [[UIPopoverController alloc]
                                initWithContentViewController:table];
    
    [self.popover presentPopoverFromRect:[view frame] inView:view
                     permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    return self;
}

-(void) selected
{
    [self.popover dismissPopoverAnimated:YES];
}

@end
