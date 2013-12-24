//
//  AttachmentViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-16.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AttachmentViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    UIWebView *web;
    NSString *url;
    UIAlertView *alert;
}

@property (copy, nonatomic) NSString *url;

@end
