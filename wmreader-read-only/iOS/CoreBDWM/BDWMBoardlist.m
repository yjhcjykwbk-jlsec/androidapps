//
//  BDWMBoardlist.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BDWMBoardlist.h"


@implementation BDWMBoardlist

@synthesize filter;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    self.filter = nil;
    [names release];
    [boards release];
    [super dealloc];
}

- (void)getNames
{
    [names release];
    names = nil;
    
    names = [[NSMutableDictionary alloc] initWithCapacity:26];
    for (int i=0; i<26; ++i) {
        NSString *key = [NSString stringWithFormat:@"%c", 'A'+i];
        NSArray *array = [[[boards objectForKey:key] allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        [names setValue:array forKey:key];
    }
}

- (void)loadFromFile
{
    [names release];
    [boards release];
    names = nil;
    boards = nil;
    self.filter = nil;
    
    boards = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/boards.plist", NSHomeDirectory()]];
    
    [self getNames];
}

+ (int)indexFromString:(NSString *)string
{
    if ([string length] == 0) {
        return 25;
    }
    unichar x = [string characterAtIndex:0], a = [@"a" characterAtIndex:0], z = [@"z" characterAtIndex:0], A = [@"A" characterAtIndex:0], Z = [@"Z" characterAtIndex:0];
    if (x >= a && x <= z) {
        return x - a;
    }
    if (x >= A && x <= Z) {
        return x - A;
    }
    return 25;
}

- (void)loadString:(NSString *)string
{
    [boards release];
    boards = nil;
    
    if (!string) {
        return;
    }
    
    NSMutableDictionary *b[26];
    boards = [[NSMutableDictionary alloc] initWithCapacity:26];
    for (int i=0; i<26; ++i) {
        b[i] = [[NSMutableDictionary alloc] init];
        [boards setValue:b[i] forKey:[NSString stringWithFormat:@"%c", 'A'+i]];
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=\"bbstop.php.board=([^\"]*)\">([^<]*)</a>" options:0 error:NULL];
    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (int i=0; i<[result count]; ++i) {
        NSTextCheckingResult *r = [result objectAtIndex:i];
        NSRange range;
        range = [r rangeAtIndex:1];
        NSString *tmpname = [string substringWithRange:range];
        range = [r rangeAtIndex:2];
        NSMutableString *tmptitle = [NSMutableString stringWithString:[string substringWithRange:range]];
        
        [Helper UnescapeHTML:tmptitle];
        [b[[BDWMBoardlist indexFromString:tmpname]] setValue:tmptitle forKey:tmpname];
    }
    
    for (int i=0; i<26; ++i) {
        [b[i] release];
    }
    
    [boards writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/boards.plist", NSHomeDirectory()] atomically:YES];
    
    [self getNames];
}

- (int)countForKey:(NSString *)key
{
    return [[names objectForKey:key] count];
}

- (NSString *)nameForKey:(NSString *)key atIndex:(int)index
{
    return [[names objectForKey:key] objectAtIndex:index];
}

- (NSString *)titleForKey:(NSString *)key atIndex:(int)index
{
    return [[boards objectForKey:key] objectForKey:[[names objectForKey:key] objectAtIndex:index]];
}

- (void)setFilter:(NSString *)string
{
    if (string == nil) {
        [filter release];
        filter = nil;
        [filteredNames release];
        filteredNames = nil;
        return;
    }
    [filter release];
    filter = [string copy];
    [filteredNames release];
    filteredNames = [[NSMutableArray alloc] init];
    if ([string length] > 0) {
        for (int i=0; i<26; ++i) {
            NSString *key = [NSString stringWithFormat:@"%c", 'A'+i];
            NSArray *array = [names objectForKey:key];
            for (int j=0; j<[array count]; ++j) {
                NSString *name = [array objectAtIndex:j];
                NSRange r = [name rangeOfString:filter options:NSCaseInsensitiveSearch];
                if (r.length)
                    [filteredNames addObject:name];
            }
        }
    }
}

- (int)filteredCount
{
    return [filteredNames count];
}

- (NSString *)filteredNameAtIndex:(int)index
{
    return [filteredNames objectAtIndex:index];
}

- (NSString *)filteredTitleAtIndex:(int)index
{
    NSString *name = [filteredNames objectAtIndex:index];
    NSString *key = [NSString stringWithFormat:@"%c", 'A'+[BDWMBoardlist indexFromString:name]];
    return [[boards objectForKey:key] objectForKey:name];
}

@end
