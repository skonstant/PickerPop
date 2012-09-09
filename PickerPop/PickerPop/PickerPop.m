//
//  PickerPop.m
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//
#import "PickerPop.h"
#import "PopTableViewController.h"

@interface PickerPop ()

@property NSArray *data;
@property UIView *initiator;
@property (copy) TapBlock action;
@property UIPopoverController *popover;
@property UIActionSheet *menu;
@property UIPickerView *pickerView;
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
        [self.popover presentPopoverFromRect:[view frame] inView:view
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

@end
