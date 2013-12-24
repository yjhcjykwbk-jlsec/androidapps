//
//  BDWMBoardlist.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"


@interface BDWMBoardlist : NSObject {
    NSMutableDictionary *boards;
    NSMutableDictionary *names;
    NSString *filter;
    NSMutableArray *filteredNames;
}

@property (copy, nonatomic) NSString *filter;

- (id)init;
- (void)dealloc;
- (void)loadFromFile;
- (void)loadString:(NSString *)string;

- (int)countForKey:(NSString *)key;
- (NSString *)nameForKey:(NSString *)key atIndex:(int)index;
- (NSString *)titleForKey:(NSString *)key atIndex:(int)index;

- (int)filteredCount;
- (NSString *)filteredNameAtIndex:(int)index;
- (NSString *)filteredTitleAtIndex:(int)index;

@end
