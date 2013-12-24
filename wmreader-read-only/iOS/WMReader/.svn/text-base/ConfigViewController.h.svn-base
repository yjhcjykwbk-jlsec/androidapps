//
//  ConfigViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration/ConfigManager.h"
#import "Configuration/ValueSelector.h"
#import "Configuration/ValueSelectorIPAD.h"
#import "Configuration/OptionSelector.h"

typedef enum tagValueSelectorState {
    ValueSelectorStateNone,
    ValueSelectorStateArticleFontsize,
    ValueSelectorStateListFontsize,
    ValueSelectorStateConnectionTimeout,
    ValueSelectorStatePopularAmount
} ValueSelectorState;

typedef enum tagOptionSelectorState {
    OptionSelectorStateNone,
    OptionSelectorStatePopularType
} OptionSelectorState;

typedef enum tagActionSheetState {
    ActionSheetStateNone,
    ActionSheetStateRestoreDefaults,
    ActionSheetStateClearFavorite
} ActionSheetState;


@interface ConfigViewController : UITableViewController <ValueSelectorDelegate, OptionSelectorDelegate, UIActionSheetDelegate> {
    ValueSelectorState valueSelectorState;
    OptionSelectorState optionSelectorState;
    ActionSheetState actionSheetState;
}

@end
