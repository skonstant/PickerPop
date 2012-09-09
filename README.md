PickerPop
=========

A library to handle a "select" menu on both iPhone and iPad.

- on the iPad, we show a UIPopover
- on the iPhone, we show a UIPickerView

Use it this way:

[[PickerPop alloc] initWithData:@[@"one", @"two", @"three"] initiator:self.button action:^(NSObject * selected) {
        //do something
    } ];
