//
//  BDWMArticle.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"


@interface BDWMArticle : NSObject {
    NSMutableString *content;
    NSMutableArray *atturls;
    NSMutableArray *attnames;
    NSString *previousPage;
    NSString *nextPage;
    NSString *firstPage;
    NSString *lastPage;
}

@property (readonly) NSMutableString *content;

@property (readonly) NSString *previousPage;
@property (readonly) NSString *nextPage;
@property (readonly) NSString *firstPage;
@property (readonly) NSString *lastPage;

- (id)init;
- (void)dealloc;

- (void)loadString:(NSString *)string;
- (void)loadFullString:(NSString *)string;

- (int)attachmentCount;
- (NSString *)attachmentURLAtIndex:(int)index;
- (NSString *)attachmentNameAtIndex:(int)index;

@end
