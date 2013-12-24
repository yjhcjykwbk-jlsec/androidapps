//
//  BoardViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BDWMBoard.h"


@interface BoardViewController : UITableViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
    ASIHTTPRequest *req;
    BDWMBoard *model;
    UIAlertView *alert;
    NSString *location;
    NSString *boardname;
    UIActionSheet *sheet;
}

@property (retain, nonatomic) ASIHTTPRequest *req;
@property (retain, nonatomic) BDWMBoard *model;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *boardname;

@end
