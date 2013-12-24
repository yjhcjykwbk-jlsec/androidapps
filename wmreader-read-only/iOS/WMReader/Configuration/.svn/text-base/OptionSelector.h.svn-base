//
//  OptionSelector.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-17.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  OptionSelector;

@protocol OptionSelectorDelegate <NSObject>

@required
- (int)optionCountForSelector:(OptionSelector *)sender;
- (int)defaultOptionForSelector:(OptionSelector *)sender;
- (NSString *)optionSelector:(OptionSelector *)sender titleAtIndex:(int)index;
- (NSString *)titleForOptionSelector:(OptionSelector *)sender;
- (NSString *)detailForOptionSelector:(OptionSelector *)sender;
- (void)optionSelector:(OptionSelector *)sender selected:(int)index;

@end

@interface OptionSelector : UITableViewController {
    id<OptionSelectorDelegate> delegate;
    UITableViewCell *selectedCell;
}

@property (assign) id<OptionSelectorDelegate> delegate;

@end
