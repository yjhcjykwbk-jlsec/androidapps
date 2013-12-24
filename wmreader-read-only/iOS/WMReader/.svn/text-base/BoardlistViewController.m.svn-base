//
//  BoardlistViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "BoardlistViewController.h"
#import "BoardViewController.h"
#import "Configuration/ConfigManager.h"


@implementation BoardlistViewController

@synthesize req, model;

- (BDWMBoardlist *)model
{
    if (!model) {
        model = [[BDWMBoardlist alloc] init];
    }
    return model;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"版面列表";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"Boardlist.png"] tag:1];
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        alert.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
        
        UISearchBar *sbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        sbar.autocorrectionType = UITextAutocorrectionTypeNo;
        sbar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.tableView.tableHeaderView = sbar;
        searchctrl = [[UISearchDisplayController alloc] initWithSearchBar:sbar contentsController:self];
        searchctrl.delegate = self;
        searchctrl.searchResultsDelegate = self;
        searchctrl.searchResultsDataSource = self;
        [sbar release];
    }
    return self;
}

- (void)dealloc
{
    [searchctrl release];
    [model release];
    [req release];
    [alert release];
    [super dealloc];
}

- (void)doSearch
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)doRefresh
{
    NSURL *url = [NSURL URLWithString:@"http://www.bdwm.net/bbs/bbsall.php"];
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
    
    self.tableView.contentOffset = CGPointMake(0, 44);
    
    UIBarButtonItem *lbar = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(doSearch)];
    self.navigationItem.leftBarButtonItem = lbar;
    [lbar release];

    UIBarButtonItem *rbar = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleBordered target:self action:@selector(doRefresh)];
    self.navigationItem.rightBarButtonItem = rbar;
    [rbar release];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Library/Preferences/boards.plist", NSHomeDirectory()]]) {
        [self.model loadFromFile];
        [self.tableView reloadData];
    } else {
        [self doRefresh];
    }
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
    if ([searchctrl isActive])
        return;
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

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.model.filter = searchString;
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
        return 26;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
        return [self.model countForKey:[NSString stringWithFormat:@"%c", section+'A']];
    return [self.model filteredCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BoardlistCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int index = [indexPath indexAtPosition:1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:[ConfigManager defaultManager].listFontsize];
    
    if (tableView == self.tableView) {
        NSString *key = [NSString stringWithFormat:@"%c", 'A' + [indexPath indexAtPosition:0]];

        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", [self.model nameForKey:key atIndex:index], [self.model titleForKey:key atIndex:index]];
        
        return cell;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", [self.model filteredNameAtIndex:index], [self.model filteredTitleAtIndex:index]];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView != self.tableView)
        return nil;
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<26; ++i) {
        [array addObject:[NSString stringWithFormat:@"%c", i+'A']];
    }
    return array;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView != self.tableView)
        return nil;
    return [NSString stringWithFormat:@"%c", section + 'A'];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [indexPath indexAtPosition:1];
    
    BoardViewController *brdctrl = [[BoardViewController alloc] init];
    if (tableView == self.tableView) {
        NSString *key = [NSString stringWithFormat:@"%c", 'A' + [indexPath indexAtPosition:0]];
        brdctrl.title = [self.model nameForKey:key atIndex:index];
        brdctrl.boardname = [self.model titleForKey:key atIndex:index];
    } else {
        brdctrl.title = [self.model filteredNameAtIndex:index];
        brdctrl.boardname = [self.model filteredTitleAtIndex:index];
    }
    
    [self.navigationController pushViewController:brdctrl animated:YES];
    [brdctrl release];
}

@end
