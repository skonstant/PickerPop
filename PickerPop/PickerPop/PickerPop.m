//
//  PickerPop.m
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//
#import "PickerPop.h"
#import "PopTableViewController.h"
#import "PopOverDateViewController.h"

@interface PickerPop ()

@property NSArray *data;
@property NSDate *date;
@property UIView *initiator;
@property (copy) TapBlock action;
@property (copy) TapBlockDate dateAction;
@property UIPopoverController *popover;
@property UIActionSheet *menu;
@property UIPickerView *pickerView;
@property UIDatePicker *datePicker;
@end

@implementation PickerPop

- (id)initWithData:(NSArray *)data initiator:(UIView *)view action:(void ( ^ )(NSObject *))predicate
{
    self = [super init];
    self.data = data;
    self.initiator = view;
    self.action = predicate;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        PopTableViewController *table = [[PopTableViewController alloc] initWithData:self.data action:^(id selected) {
            [self.popover dismissPopoverAnimated:YES];
            self.action(selected);
        } ];
        
        self.popover = [[UIPopoverController alloc]
                                initWithContentViewController:table];
        
        [self.popover presentPopoverFromRect:[view frame] inView:[view superview]
                     permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        self.menu = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:nil
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        
        [self.menu setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40,0,0)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        
        [self.menu addSubview:self.pickerView];
        
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
        closeButton.momentary = YES;
        closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blackColor];
        [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
        [self.menu addSubview:closeButton];
        [self.menu showInView:[[UIApplication sharedApplication] keyWindow]];
        [self.menu setBounds:CGRectMake(0, 0, 320, 485)];
    }
    return self;
}

- (id)initWithDate:(NSDate *)date initiator:(UIView *)view action:(void ( ^ )(NSDate *))predicate
{
    self = [super init];
    self.date = date;
    self.initiator = view;
    self.dateAction = predicate;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        PopOverDateViewController *dateView = [[PopOverDateViewController alloc] initWithDate:self.date action:^(id selected) {
            [self.popover dismissPopoverAnimated:YES];
            self.dateAction(selected);
        } ];
        
        self.popover = [[UIPopoverController alloc]
                        initWithContentViewController:dateView];
        
        [self.popover presentPopoverFromRect:[view frame] inView:[view superview]
                    permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        self.menu = [[UIActionSheet alloc] initWithTitle:nil
                                                delegate:nil
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
        
        [self.menu setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40,0,0)];
        self.datePicker.timeZone = [NSTimeZone localTimeZone];
        [self.menu addSubview:self.datePicker];
        
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
        closeButton.momentary = YES;
        closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blackColor];
        [closeButton addTarget:self action:@selector(dismissActionSheetDate) forControlEvents:UIControlEventValueChanged];
        [self.menu addSubview:closeButton];
        [self.menu showInView:[[UIApplication sharedApplication] keyWindow]];
        [self.menu setBounds:CGRectMake(0, 0, 320, 485)];
    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.data count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.data objectAtIndex:row];
}

- (void)dismissActionSheet
{
    [self.menu dismissWithClickedButtonIndex:0 animated:YES];
    self.action([self.data objectAtIndex:[self.pickerView selectedRowInComponent:0]]);
}

- (void)dismissActionSheetDate
{
    [self.menu dismissWithClickedButtonIndex:0 animated:YES];
    self.dateAction(self.datePicker.date);
}


@end
