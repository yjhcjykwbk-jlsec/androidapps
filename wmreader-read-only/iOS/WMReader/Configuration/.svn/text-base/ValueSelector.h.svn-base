//
//  ValueSelector.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-15.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ValueSelector;

@protocol ValueSelectorDelegate <NSObject>

@required
- (void)valueSelector:(ValueSelector *)sender valueChangedTo:(float)newValue;
- (float)maxValueForValueSelector:(ValueSelector *)sender;
- (float)minValueValueSelector:(ValueSelector *)sender;
- (float)valueForValueSelector:(ValueSelector *)sender;
- (NSString *)textForValueSelector:(ValueSelector *)sender;

@end

@interface ValueSelector : UIViewController {
    id<ValueSelectorDelegate> delegate;
    UILabel *valueLabel;
    UILabel *textLabel;
    UISlider *slider;
}

@property (assign) id<ValueSelectorDelegate> delegate;
@property (retain, nonatomic) IBOutlet UILabel *valueLabel;
@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (retain, nonatomic) IBOutlet UISlider *slider;

- (IBAction)changed:(UISlider *)sender;

@end
