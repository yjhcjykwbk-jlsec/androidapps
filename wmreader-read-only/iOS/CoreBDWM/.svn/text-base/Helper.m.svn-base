//
//  Helper.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-16.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "Helper.h"


@implementation Helper

+ (void)UnescapeHTML:(NSMutableString *)html
{
    NSRange r;
    r.location = 0;
    
    r.length = [html length];
    [html replaceOccurrencesOfString:@"&lt;" withString:@"<" options:0 range:r];
    
    r.length = [html length];
    [html replaceOccurrencesOfString:@"&gt;" withString:@">" options:0 range:r];
    
    r.length = [html length];
    [html replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:r];
    
    r.length = [html length];
    [html replaceOccurrencesOfString:@"&amp;" withString:@"&" options:0 range:r];
}

@end
