//
//  BDWMBoard.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"


@interface BDWMBoard : NSObject {
    NSString *previousPage;
    NSString *nextPage;
    NSString *latestPage;
    NSMutableArray *titles;
    NSMutableArray *urls;
}

@property (readonly) NSString *previousPage;
@property (readonly) NSString *nextPage;
@property (readonly) NSString *latestPage;

- (id)init;
- (void)dealloc;
- (void)loadString:(NSString *)string;

- (int)count;
- (NSString *)titleAtIndex:(int)index;
- (NSString *)URLAtIndex:(int)index;

@end
