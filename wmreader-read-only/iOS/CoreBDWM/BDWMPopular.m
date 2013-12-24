//
//  BDWMPopular.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BDWMPopular.h"


@implementation BDWMPopular

@synthesize count;

- (id)init
{
    self = [super init];
    return self;
}

- (void)loadString:(NSString *)string
{
    for (int i=0; i<count; ++i) {
        [urls[i] release];
        [titles[i] release];
        urls[i] = nil;
        titles[i] = nil;
    }
    count = 0;
    
    if (!string) {
        return;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a href='(bbstcon.php[^>]*)'>([^<]*)</a>" options:0 error:NULL];
    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    count = MIN(100, [result count]);
    
    for (int i=0; i<count; ++i) {
        NSTextCheckingResult *r = [result objectAtIndex:i];
        NSRange range;
        range = [r rangeAtIndex:1];
        urls[i] = [[string substringWithRange:range] retain];
        range = [r rangeAtIndex:2];
        NSMutableString *tmptitle = [NSMutableString stringWithString:[string substringWithRange:range]];
        [Helper UnescapeHTML:tmptitle];
        titles[i] = [tmptitle retain];
    }
}

- (NSString *)URLAtIndex:(int)index
{
    if (index < 0 || index >= count) {
        return nil;
    }
    return urls[index];
}

- (NSString *)titleAtIndex:(int)index
{
    if (index < 0 || index >= count) {
        return nil;
    }
    return titles[index];
}

- (void)dealloc
{
    for (int i=0; i<count; ++i) {
        [urls[i] release];
        [titles[i] release];
    }
    [super dealloc];
}

@end
