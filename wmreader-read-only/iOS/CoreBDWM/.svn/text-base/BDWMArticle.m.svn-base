//
//  BDWMArticle.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BDWMArticle.h"


@implementation BDWMArticle

@synthesize content;
@synthesize previousPage, nextPage, firstPage, lastPage;

- (id)init
{
    self = [super init];
    return self;
}

- (void)loadString:(NSString *)string
{
    [previousPage release];
    [nextPage release];
    [firstPage release];
    [lastPage release];
    [attnames release];
    [atturls release];
    [content release];
    content = nil;
    atturls = nil;
    attnames = nil;
    previousPage = nil;
    nextPage = nil;
    firstPage = nil;
    lastPage = nil;
    
    if (!string) {
        return;
    }
    
    NSRange rbeg, rend;
    rbeg = [string rangeOfString:@"<pre>"];
    rend = [string rangeOfString:@"</pre>"];
    
    if(rbeg.location != NSNotFound && rend.location != NSNotFound && rbeg.location < rend.location) {
        NSMutableString *tmpstr = [[NSMutableString alloc] initWithString:[string substringWithRange:NSMakeRange(rbeg.location+5, rend.location-rbeg.location-5)]];
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:0 error:NULL];
        [regex replaceMatchesInString:tmpstr options:0 range:NSMakeRange(0, [tmpstr length]) withTemplate:@""];
        
        content = [[NSMutableString alloc] initWithString:tmpstr];
        [tmpstr release];
        
        [Helper UnescapeHTML:content];
    }
    
    atturls = [[NSMutableArray alloc] init];
    attnames = [[NSMutableArray alloc] init];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(http://attach..bdwm.net/[^\"]*)\"[^>]*>([^<]*)</a>" options:0 error:NULL];
    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (int i=0; i<[result count]; ++i) {
        NSTextCheckingResult *r = [result objectAtIndex:i];
        NSRange range;
        range = [r rangeAtIndex:1];
        NSString *tmpurl = [string substringWithRange:range];
        range = [r rangeAtIndex:2];
        NSMutableString *tmpname = [NSMutableString stringWithString:[string substringWithRange:range]];
        
        [Helper UnescapeHTML:tmpname];
        [atturls addObject:tmpurl];
        [attnames addObject:tmpname];
    }
}

- (void)loadFullString:(NSString *)string
{
    [previousPage release];
    [nextPage release];
    [firstPage release];
    [lastPage release];
    [attnames release];
    [atturls release];
    [content release];
    content = nil;
    atturls = nil;
    attnames = nil;
    previousPage = nil;
    nextPage = nil;
    firstPage = nil;
    lastPage = nil;
    
    if (!string) {
        return;
    }
    
    NSRange rbeg, rend, range;
    content = [[NSMutableString alloc] init];
    
    range.location = 0;
    range.length = [string length];
    while (range.length > 0) {
        rbeg = [string rangeOfString:@"<pre>" options:0 range:range];
        rend = [string rangeOfString:@"</pre>" options:0 range:range];
        if(rbeg.location == NSNotFound || rend.location == NSNotFound || rbeg.location >= rend.location)
            break;
        [content appendString:[string substringWithRange:NSMakeRange(rbeg.location+5, rend.location-rbeg.location-5)]];
        [content appendString:@"\n"];
        range.location = rend.location + 5;
        range.length = [string length] - range.location;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:0 error:NULL];
    [regex replaceMatchesInString:content options:0 range:NSMakeRange(0, [content length]) withTemplate:@""];
    [Helper UnescapeHTML:content];
    
    atturls = [[NSMutableArray alloc] init];
    attnames = [[NSMutableArray alloc] init];
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"(http://attach..bdwm.net/[^\"]*)\"[^>]*>([^<]*)</a>" options:0 error:NULL];
    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (int i=0; i<[result count]; ++i) {
        NSTextCheckingResult *r = [result objectAtIndex:i];
        range = [r rangeAtIndex:1];
        NSString *tmpurl = [string substringWithRange:range];
        range = [r rangeAtIndex:2];
        NSMutableString *tmpname = [NSMutableString stringWithString:[string substringWithRange:range]];
        
        [Helper UnescapeHTML:tmpname];
        [atturls addObject:tmpurl];
        [attnames addObject:tmpname];
    }
    
    NSTextCheckingResult *r;
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.{0,5}(bbstcon.php[^>]*)>上一页</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        previousPage = [[string substringWithRange:range] retain];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.{0,5}(bbstcon.php[^>]*)>下一页</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        nextPage = [[string substringWithRange:range] retain];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.{0,5}(bbstcon.php[^>]*)>第一页</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        firstPage = [[string substringWithRange:range] retain];
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.{0,5}(bbstcon.php[^>]*)>末页</a>" options:0 error:NULL];
    r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    range = [r rangeAtIndex:1];
    if (r && range.length) {
        lastPage = [[string substringWithRange:range] retain];
    }
}

- (int)attachmentCount
{
    return [atturls count];
}

- (NSString *)attachmentURLAtIndex:(int)index
{
    return [atturls objectAtIndex:index];
}

- (NSString *)attachmentNameAtIndex:(int)index
{
    return [attnames objectAtIndex:index];
}

- (void)dealloc
{
    [previousPage release];
    [nextPage release];
    [firstPage release];
    [lastPage release];
    [atturls release];
    [attnames release];
    [content release];
    [super dealloc];
}

@end
