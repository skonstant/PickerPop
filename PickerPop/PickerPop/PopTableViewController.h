//
//  PopTableViewController.h
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTableViewController : UITableViewController
- (id)initWithData:(NSArray *)data action:(void ( ^ )(NSObject *))predicate;
@end
