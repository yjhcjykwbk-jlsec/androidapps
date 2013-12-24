//
//  BDWMBoard.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BDWMBoard.h"
#import "ConfigManager.h"


@implementation BDWMBoard

@synthesize previousPage, nextPage, latestPage;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    [previousPage release];
    [nextPage release];
    [latestPage release];
    [titles release];
    [urls release];
    [super dealloc];
}

- (void)loadString:(NSString *)string
{
    [previousPage release];
    [nextPage release];
    [latestPage release];
    [titles release];
    [urls release];
    previousPage = nil;
    nextPage = nil;
    latestPage = nil;
    titles = nil;
    urls = nil;
    
    if (!string) {
        return;
    }
    
    titles = [[NSMutableArray alloc] init];
    urls = [[NSMutableArray alloc] init];
    NSRegularExpression *regex;
    if ([ConfigManager defaultManager].showTopArticles)
        regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"?(bbst?con.php[^\"]*)\">([^<]*)(</span>)?</a>" options:0 error:NULL];
    else
        regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(bbst?con.php[^\"]*)\">([^<]*)</a>" options:0 error:NULL];
    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (int i=0; i<[result count]; ++i) {
        NSTextCheckingResult *r = [result objectAtIndex:i];
        NSRange range;
        range = [r rangeAtIndex:1];
        NSString *tmpurl = [string substringWithRange:range];
        range = [r rangeAtIndex:2];
        range.location += 3;
        range.length -= 3;
        NSMutableString *tmptitle = [NSMutableString stringWithString:[string substringWithRange:range]];
        
        [Helper UnescapeHTML:tmptitle];
        [urls addObject:tmpurl];
        [titles addObject:tmptitle];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(bbstop.php[^\"]*)\">上页</a>" options:0 error:NULL];
    NSTextCheckingResult *r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    NSRange range = [r rangeAtIndex:1];
    if (r && range.length) {
        previousPage = [[string substringWithRange:range] retain];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(bbstop.php[^\"]*)\">下页</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        nextPage = [[string substringWithRange:range] retain];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(bbstop.php[^\"]*)\">最新</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        latestPage = [[string substringWithRange:range] retain];
    }
}

- (int)count
{
    return [titles count];
}

- (NSString *)titleAtIndex:(int)index
{
    return [titles objectAtIndex:index];
}

- (NSString *)URLAtIndex:(int)index
{
    return [urls objectAtIndex:index];
}

@end
