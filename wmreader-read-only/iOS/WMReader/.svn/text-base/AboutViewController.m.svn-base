//
//  AboutViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"关于";
        for (int i=0; i<4; ++i) {
            cells[i] = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
            if (i<3) {
				cells[i].selectionStyle = UITableViewCellSelectionStyleNone;
			}
        }
		cells[0].textLabel.text = @"名称";
        cells[0].detailTextLabel.text = @"未名阅读器";
		cells[1].textLabel.text = @"版本";
        cells[1].detailTextLabel.text = @"0.1";
		cells[2].textLabel.text = @"作者";
        cells[2].detailTextLabel.text = @"coolypf";
		cells[3].textLabel.text = @"博客";
        cells[3].detailTextLabel.text = @"http://hi.baidu.com/coolypf";
    }
    return self;
}

- (void)dealloc
{
    for (int i=0; i<4; ++i) {
        [cells[i] release];
    }
    [super dealloc];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cells[[indexPath indexAtPosition:1]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:1] == 3) {
        cells[3].selected = NO;
		NSURL *url = [NSURL URLWithString:@"http://hi.baidu.com/coolypf"];
		[[UIApplication sharedApplication] openURL:url];
	}
}

@end
