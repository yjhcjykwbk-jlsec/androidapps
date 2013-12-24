//
//  ConfigManager.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-15.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "ConfigManager.h"


@implementation ConfigManager

@synthesize boardNeedsRefresh, popularNeedsRefresh;

- (float)articleFontsize
{
    NSNumber *n = [config objectForKey:@"ArticleFontsize"];
    float val = [n floatValue];
    if (val >= 8.0 && val <= 20.0) {
        return val;
    }
    return [UIFont systemFontSize];
}

- (void)setArticleFontsize:(float)articleFontsize
{
    if (articleFontsize >= 8.0 && articleFontsize <= 20.0) {
        [config setObject:[NSNumber numberWithFloat:articleFontsize] forKey:@"ArticleFontsize"];
    }
}

- (float)listFontsize
{ 
    NSNumber *n = [config objectForKey:@"ListFontsize"];
    float val = [n floatValue];
    if (val >= 8.0 && val <= 20.0) {
        return val;
    }
    return [UIFont labelFontSize];
}

- (void)setListFontsize:(float)listFontsize
{
    if (listFontsize >= 8.0 && listFontsize <= 20.0) {
        [config setObject:[NSNumber numberWithFloat:listFontsize] forKey:@"ListFontsize"];
    }
}

- (float)connectionTimeout
{
    NSNumber *n = [config objectForKey:@"ConnectionTimeout"];
    float val = [n floatValue];
    if (val >= 1.0 && val <= 60.0) {
        return val;
    }
    return 10.0;
}

- (void)setConnectionTimeout:(float)connectionTimeout
{
    if (connectionTimeout >= 1.0 && connectionTimeout <= 60.0) {
        [config setObject:[NSNumber numberWithFloat:connectionTimeout] forKey:@"ConnectionTimeout"];
    }
}

- (int)popularAmount
{
    NSNumber *n = [config objectForKey:@"PopularAmount"];
    int val = [n intValue];
    if (val >= 1 && val <= 100) {
        return val;
    }
    return 10;
}

- (void)setPopularAmount:(int)popularAmount
{
    if (popularAmount >= 1 && popularAmount <= 100) {
        [config setObject:[NSNumber numberWithInt:popularAmount] forKey:@"PopularAmount"];
    }
}

- (int)popularType
{
    NSNumber *n = [config objectForKey:@"PopularType"];
    int val = [n intValue];
    if (val == 7 || val == 180 || val == 2520) {
        return val;
    }
    return 180;
}

- (void)setPopularType:(int)popularType
{
    if (popularType == 7 || popularType == 180 || popularType == 2520) {
        if (popularType != self.popularType) {
            popularNeedsRefresh = YES;
        }
        [config setObject:[NSNumber numberWithInt:popularType] forKey:@"PopularType"];
    }
}

- (BOOL)showTopArticles
{
    NSNumber *n = [config objectForKey:@"ShowTopArticles"];
    return [n boolValue];
}

- (void)setShowTopArticles:(BOOL)showTopArticles
{
    if (showTopArticles != self.showTopArticles)
        boardNeedsRefresh = YES;
    [config setObject:[NSNumber numberWithBool:showTopArticles] forKey:@"ShowTopArticles"];
}

- (BOOL)showArticleReply
{
    NSNumber *n = [config objectForKey:@"ShowArticleReply"];
    return [n boolValue];
}

- (void)setShowArticleReply:(BOOL)showArticleReply
{
    [config setObject:[NSNumber numberWithBool:showArticleReply] forKey:@"ShowArticleReply"];
}

- (NSMutableDictionary *)favorite
{
    NSMutableDictionary *ret = [config objectForKey:@"favorite"];
    if (!ret) {
        ret = [NSMutableDictionary dictionary];
        [config setObject:ret forKey:@"favorite"];
    }
    return ret;
}

- (id)init
{
    self = [super init];
    if (self) {
        config = [[NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/config.plist", NSHomeDirectory()]] retain];
        if (!config) {
            config = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)save
{
    [config writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/config.plist", NSHomeDirectory()] atomically:YES];
}

- (void)restoreDefaults
{
    self.articleFontsize = [UIFont systemFontSize];
    self.listFontsize = [UIFont labelFontSize];
    self.connectionTimeout = 10.0;
    self.popularAmount = 10;
    self.popularType = 180;
    self.showTopArticles = NO;
    self.showArticleReply = NO;
    [self save];
}

- (void)dealloc
{
    [config release];
    [super dealloc];
}

+ (ConfigManager *)defaultManager
{
    static ConfigManager *instance = nil;
    if (!instance) instance = [[ConfigManager alloc] init];
    return instance;
}

@end
