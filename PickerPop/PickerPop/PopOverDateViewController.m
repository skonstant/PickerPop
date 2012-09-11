//
//  PopOverDateViewController.m
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 11/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//

#import "PopOverDateViewController.h"
#import "PickerPop.h"

@interface PopOverDateViewController ()
@property IBOutlet UIDatePicker *datePicker;
@property (copy) TapBlockDate action;
@property NSDate *date;
@end

@implementation PopOverDateViewController

- (id)initWithDate:(NSDate *)date action:(void ( ^ )(NSDate *))predicate
{
    self = [super init];
    if (self) {
        self.date = date;
        self.action = predicate;
        CGSize size = CGSizeMake(320, 260);
        self.contentSizeForViewInPopover = size;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setDate:self.date];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(IBAction)doneClicked:(id)sender{
    self.action(self.datePicker.date);
}

@end
