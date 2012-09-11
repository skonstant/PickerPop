//
//  PopOverDateViewController.h
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 11/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverDateViewController : UIViewController

- (id)initWithDate:(NSDate *)date action:(void ( ^ )(NSDate *))predicate;

@end
