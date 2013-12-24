//
//  PopularViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "PopularViewController.h"
#import "ArticleViewController.h"
#import "Configuration/ConfigManager.h"


@implementation PopularViewController

@synthesize model, req;

- (BDWMPopular *)model
{
    if (!model) {
        model = [[BDWMPopular alloc] init];
    }
    return model;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"热门话题";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"Popular.png"] tag:0];
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)dealloc
{
    [req release];
    [model release];
    [alert release];
    [super dealloc];
}

- (void)doRefresh
{
    [ConfigManager defaultManager].popularNeedsRefresh = NO;
    NSString *str = [NSString stringWithFormat:@"http://www.bdwm.net/bbs/ListPostTops.php?halfLife=%d", [ConfigManager defaultManager].popularType];
    NSURL *url = [NSURL URLWithString:str];
    self.req = [ASIHTTPRequest requestWithURL:url];
    self.req.timeOutSeconds = [ConfigManager defaultManager].connectionTimeout;
    self.req.delegate = self;
    self.req.shouldContinueWhenAppEntersBackground = YES;
    [self.req startAsynchronous];
    alert.title = @"载入中⋯⋯";
    alert.message = nil;
    [alert show];
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
    [self.model loadString:string];
    [string release];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    [self.tableView reloadData];
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    [self.req clearDelegatesAndCancel];
    self.req = nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([ConfigManager defaultManager].popularNeedsRefresh)
        [self doRefresh];
    else 
        [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MIN([ConfigManager defaultManager].popularAmount, self.model.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PopularCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.model titleAtIndex:[indexPath indexAtPosition:1]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:[ConfigManager defaultManager].listFontsize];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int at = [indexPath indexAtPosition:1];
    ArticleViewController *artctrl = [[ArticleViewController alloc] initWithLocation:[self.model URLAtIndex:at]];
    [self.navigationController pushViewController:artctrl animated:YES];
    [artctrl release];
}

@end
