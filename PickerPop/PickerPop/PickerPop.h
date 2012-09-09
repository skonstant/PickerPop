//
//  PickerPop.h
//  PickerPop
//
//  Created by Stephane Konstantaropoulos on 09/09/12.
//  Copyright (c) 2012 Stephane Konstantaropoulos. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TapBlock)(NSObject *);

@interface PickerPop : NSObject
- (id)initWithData:(NSArray *)data initiator:(UIView *)view action:(void ( ^ )(NSObject *))predicate;
@end
