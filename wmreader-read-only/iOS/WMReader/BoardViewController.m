//
//  BoardViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BoardViewController.h"
#import "ArticleViewController.h"
#import "Configuration/ConfigManager.h"


@implementation BoardViewController

@synthesize req, model, location, boardname;

- (BDWMBoard *)model
{
    if (!model) {
        model = [[BDWMBoard alloc] init];
    }
    return model;
}

- (NSString *)location
{
    if (!location) {
        location = [[NSString alloc] initWithFormat:@"http://www.bdwm.net/bbs/bbstop.php?board=%@", self.title];
    }
    return location;
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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"版面列表操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"刷新", @"上一页", @"下一页", @"最新主题", @"收藏版面", nil];
    }
    return self;
}

- (void)dealloc
{
    [sheet release];
    [location release];
    [model release];
    [req release];
    [alert release];
    [super dealloc];
}

- (void)addFavorite
{
    [[ConfigManager defaultManager].favorite setObject:self.boardname forKey:self.title];
}


- (void)doRefresh
{
    [ConfigManager defaultManager].boardNeedsRefresh = NO;
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
            if (self.model.previousPage) {
                self.location = self.model.previousPage;
                [self doRefresh];
            }
            break;
        case 2:
            if (self.model.nextPage) {
                self.location = self.model.nextPage;
                [self doRefresh];
            }
            break;
        case 3:
            if (self.model.latestPage) {
                self.location = self.model.latestPage;
                [self doRefresh];
            }
            break;
        case 4:
            [self addFavorite];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([ConfigManager defaultManager].boardNeedsRefresh)
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
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BoardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
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
