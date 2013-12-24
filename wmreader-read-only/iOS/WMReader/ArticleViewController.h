//
//  ArticleViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDWMArticle.h"
#import "ASIHTTPRequest.h"


@interface ArticleViewController : UIViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
    BDWMArticle *model;
    ASIHTTPRequest *req;
    NSString *location;
    UIAlertView *alert;
    UIActionSheet *sheet;
    BOOL showReply;
}

@property (retain, nonatomic) BDWMArticle *model;
@property (retain, nonatomic) ASIHTTPRequest *req;
@property (copy, nonatomic) NSString *location;

- (id)initWithLocation:(NSString *)string;

@end
