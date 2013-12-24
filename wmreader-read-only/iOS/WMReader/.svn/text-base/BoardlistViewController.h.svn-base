//
//  BoardlistViewController.h
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BDWMBoardlist.h"


@interface BoardlistViewController : UITableViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate, UISearchDisplayDelegate> {
    ASIHTTPRequest *req;
    BDWMBoardlist *model;
    UIAlertView *alert;
    UIActionSheet *sheet;
    UISearchDisplayController *searchctrl;
}

@property (retain, nonatomic) ASIHTTPRequest *req;
@property (retain, nonatomic) BDWMBoardlist *model;

@end
