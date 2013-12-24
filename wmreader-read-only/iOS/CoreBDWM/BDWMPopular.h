//
//  BDWMPopular.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"


@interface BDWMPopular : NSObject {
    int count;
    NSString *urls[100];
    NSString *titles[100];
}

@property int count;

- (id)init;
- (void)loadString:(NSString *)string;
- (NSString *)URLAtIndex:(int)index;
- (NSString *)titleAtIndex:(int)index;
- (void)dealloc;

@end
