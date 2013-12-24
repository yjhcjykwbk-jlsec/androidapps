//
//  ArticleViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "ArticleViewController.h"
#import "Configuration/ConfigManager.h"
#import "AttachmentlistViewController.h"


@implementation ArticleViewController

@synthesize model, req, location;

- (BDWMArticle *)model
{
    if (!model) {
        model = [[BDWMArticle alloc] init];
    }
    return model;
}

- (void)setLocation:(NSString *)string
{
    NSString *bak = location;
    if ([string rangeOfString:@"http://" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        location = [[NSString stringWithFormat:@"http://www.bdwm.net/bbs/%@", string] retain];
    } else {
        location = [string copy];
    }
    [bak release];
}

- (void)loadSheet
{
    [sheet release];
    sheet = nil;
    if (showReply) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"阅读文章操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"刷新", @"查看附件", @"隐藏回帖", @"上一页", @"下一页", @"第一页", @"末页", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"阅读文章操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"刷新", @"查看附件", @"显示回帖", nil];
    }
}

- (id)initWithLocation:(NSString *)string
{
    self = [super init];
    if (self) {
        self.title = @"阅读文章";
        self.location = string;
        showReply = [ConfigManager defaultManager].showArticleReply;
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
        
        [self loadSheet];
        
    }
    return self;
}

- (void)doRefresh
{
    NSURL *url = [NSURL URLWithString:self.location];
    self.req = [ASIHTTPRequest requestWithURL:url];
    self.req.timeOutSeconds = [ConfigManager defaultManager].connectionTimeout;
    self.req.delegate = self;
    self.req.shouldContinueWhenAppEntersBackground = YES;
    [self.req startAsynchronous];
    alert.title = @"载入中⋯⋯";
    alert.message = nil;
    [alert show];
}

- (void)showAttachments
{
    AttachmentlistViewController *vc = [[AttachmentlistViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)showFunctions
{
    [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:NO];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
    int at = buttonIndex - actionSheet.firstOtherButtonIndex;
    switch (at) {
        case 0:
            [self doRefresh];
            break;
        case 1:
            [self showAttachments];
            break;
        case 2:
            if (showReply) {
                showReply = NO;
                if (self.model.firstPage)
                    self.location = self.model.firstPage;
                [self loadSheet];
                [self doRefresh];
            } else {
                showReply = YES;
                [self loadSheet];
                [self doRefresh];
            }
            break;
        case 3:
            if (self.model.previousPage) {
                self.location = self.model.previousPage;
                [self doRefresh];
            }
            break;
        case 4:
            if (self.model.nextPage) {
                self.location = self.model.nextPage;
                [self doRefresh];
            }
            break;
        case 5:
            if (self.model.firstPage) {
                self.location = self.model.firstPage;
                [self doRefresh];
            }
            break;
        case 6:
            if (self.model.lastPage) {
                self.location = self.model.lastPage;
                [self doRefresh];
            }
            break;
        default:
            break;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    alert.title = @"载入失败";
    alert.message = [request.error description];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    NSString *string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    if (showReply)
        [self.model loadFullString:string];
    else
        [self.model loadString:string];
    [string release];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    
    ((UITextView *)self.view).text = model.content;
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    [self.req clearDelegatesAndCancel];
    self.req = nil;
}

- (void)dealloc
{
    [sheet release];
    [alert release];
    [location release];
    [req release];
    [model release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
    UITextView *tv = [[UITextView alloc] init];
    tv.editable = NO;
    tv.font = [UIFont systemFontOfSize:[ConfigManager defaultManager].articleFontsize];
    self.view = tv;
    [tv release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rbar = [[UIBarButtonItem alloc] initWithTitle:@"功能" style:UIBarButtonItemStyleBordered target:self action:@selector(showFunctions)];
    self.navigationItem.rightBarButtonItem = rbar;
    [rbar release];
    
    [self doRefresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UITextView *)(self.view)).font = [UIFont systemFontOfSize:[ConfigManager defaultManager].articleFontsize];
}

@end
