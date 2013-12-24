//
//  AttachmentViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-16.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "AttachmentViewController.h"
#import "Configuration/ConfigManager.h"


@implementation AttachmentViewController

@synthesize url;

- (id)init
{
    self = [super init];
    if (self) {
        alert = [[UIAlertView alloc] initWithTitle:@"载入中⋯⋯" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
        web = [[UIWebView alloc] init];
        web.scalesPageToFit = YES;
        web.delegate = self;
        self.title = @"查看附件";
    }
    return self;
}

- (void)dealloc
{
    [alert release];
    [url release];
    [web release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)doRefresh
{
    NSURL *u = [NSURL URLWithString:url];
    NSURLRequest *req = [NSURLRequest requestWithURL:u cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:[ConfigManager defaultManager].connectionTimeout];
    [web loadRequest:req];
    [alert show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [alert dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    [web stopLoading];
}

- (void)loadView
{
    self.view = web;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rbar = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleBordered target:self action:@selector(doRefresh)];
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

@end
