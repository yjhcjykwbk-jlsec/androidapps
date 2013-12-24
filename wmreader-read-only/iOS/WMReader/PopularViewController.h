//
//  PopularViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BDWMPopular.h"


@interface PopularViewController : UITableViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate> {
    BDWMPopular *model;
    UIAlertView *alert;
    ASIHTTPRequest *req;
}

@property (retain, nonatomic) BDWMPopular *model;
@property (retain, nonatomic) ASIHTTPRequest *req;

@end
