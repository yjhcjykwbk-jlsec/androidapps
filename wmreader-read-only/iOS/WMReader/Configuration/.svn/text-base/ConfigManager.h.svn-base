//
//  ConfigManager.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-15.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConfigManager : NSObject {
    NSMutableDictionary *config;
    BOOL boardNeedsRefresh;
    BOOL popularNeedsRefresh;
}

+ (ConfigManager *)defaultManager;

@property float articleFontsize;
@property float listFontsize;
@property float connectionTimeout;
@property int popularAmount;
@property int popularType;
@property BOOL showTopArticles;
@property BOOL showArticleReply;

@property (readonly) NSMutableDictionary *favorite;

@property BOOL boardNeedsRefresh;
@property BOOL popularNeedsRefresh;

- (void)save;
- (void)restoreDefaults;
- (void)dealloc;

@end
