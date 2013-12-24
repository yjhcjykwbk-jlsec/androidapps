//
//  ConfigViewController.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-14.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "ConfigViewController.h"
#import "Configuration/ConfigManager.h"
#import "AboutViewController.h"


@implementation ConfigViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"设置";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"Config.png"] tag:3];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)valueSelector:(ValueSelector *)sender valueChangedTo:(float)newValue
{
    switch (valueSelectorState) {
        case ValueSelectorStateArticleFontsize:
            [ConfigManager defaultManager].articleFontsize = newValue;
            break;
        case ValueSelectorStateListFontsize:
            [ConfigManager defaultManager].listFontsize = newValue;
            break;
        case ValueSelectorStateConnectionTimeout:
            [ConfigManager defaultManager].connectionTimeout = newValue;
            break;
        case ValueSelectorStatePopularAmount:
            [ConfigManager defaultManager].popularAmount = newValue;
            break;
        default:
            break;
    }
}

- (float)valueForValueSelector:(ValueSelector *)sender
{
    float ret = 0;
    switch (valueSelectorState) {
        case ValueSelectorStateArticleFontsize:
            ret = [ConfigManager defaultManager].articleFontsize;
            break;
        case ValueSelectorStateListFontsize:
            ret = [ConfigManager defaultManager].listFontsize;
            break;
        case ValueSelectorStateConnectionTimeout:
            ret = [ConfigManager defaultManager].connectionTimeout;
            break;
        case ValueSelectorStatePopularAmount:
            ret = [ConfigManager defaultManager].popularAmount;
            break;
        default:
            break;
    }
    return ret;
}

- (float)minValueValueSelector:(ValueSelector *)sender
{
    float ret = 0;
    switch (valueSelectorState) {
        case ValueSelectorStateArticleFontsize:
        case ValueSelectorStateListFontsize:
            ret = 8.0;
            break;
        case ValueSelectorStateConnectionTimeout:
            ret = 1.0;
            break;
        case ValueSelectorStatePopularAmount:
            ret = 1;
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *)textForValueSelector:(ValueSelector *)sender
{
    NSString *ret = nil;
    switch (valueSelectorState) {
        case ValueSelectorStateArticleFontsize:
            ret = @"设置文章内容的字体大小";
            break;
        case ValueSelectorStateListFontsize:
            ret = @"设置版面、文章和附件列表的字体大小";
            break;
        case ValueSelectorStateConnectionTimeout:
            ret = @"设置网络连接的超时";
            break;
        case ValueSelectorStatePopularAmount:
            ret = @"设置想要显示的热门话题数目";
            break;
        default:
            break;
    }
    return ret;
}

- (float)maxValueForValueSelector:(ValueSelector *)sender
{
    float ret = 0;
    switch (valueSelectorState) {
        case ValueSelectorStateArticleFontsize:
        case ValueSelectorStateListFontsize:
            ret = 20.0;
            break;
        case ValueSelectorStateConnectionTimeout:
            ret = 60.0;
            break;
        case ValueSelectorStatePopularAmount:
            ret = 100;
            break;
        default:
            break;
    }
    return ret;
}

- (int)optionCountForSelector:(OptionSelector *)sender
{
    int ret = 0;
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            ret = 3;
            break;
        default:
            break;
    }
    return ret;
}

- (int)defaultOptionForSelector:(OptionSelector *)sender
{
    int ret = 0;
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            switch ([ConfigManager defaultManager].popularType) {
                case 7:
                    ret = 0;
                    break;
                case 180:
                    ret = 1;
                    break;
                case 2520:
                    ret = 2;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *)optionSelector:(OptionSelector *)sender titleAtIndex:(int)index
{
    NSString *ret = nil;
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            switch (index) {
                case 0:
                    ret = @"即时";
                    break;
                case 1:
                    ret = @"今日";
                    break;
                case 2:
                    ret = @"本周";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *)titleForOptionSelector:(OptionSelector *)sender
{
    NSString *ret = nil;
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            ret = @"热门话题类型";
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *)detailForOptionSelector:(OptionSelector *)sender
{
    NSString *ret = nil;
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            ret = @"选择想要显示的热门话题类型";
            break;
        default:
            break;
    }
    return ret;
}

- (void)optionSelector:(OptionSelector *)sender selected:(int)index
{
    switch (optionSelectorState) {
        case OptionSelectorStatePopularType:
            switch (index) {
                case 0:
                    [ConfigManager defaultManager].popularType = 7;
                    break;
                case 1:
                    [ConfigManager defaultManager].popularType = 180;
                    break;
                case 2:
                    [ConfigManager defaultManager].popularType = 2520;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)showTopArticlesChanged:(UISwitch *)sender
{
    [ConfigManager defaultManager].showTopArticles = sender.on;
}

- (void)showArticleReplyChanged:(UISwitch *)sender
{
    [ConfigManager defaultManager].showArticleReply = sender.on;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        switch (actionSheetState) {
            case ActionSheetStateRestoreDefaults:
                [[ConfigManager defaultManager] restoreDefaults];
                [self.tableView reloadData];
                break;
            case ActionSheetStateClearFavorite:
                [[ConfigManager defaultManager].favorite removeAllObjects];
                [[ConfigManager defaultManager] save];
                break;
            default:
                break;
        }
    }
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int ret = 0;
    switch (section) {
        case 0:
            ret = 7;
            break;
        case 1:
            ret = 3;
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    switch (section) {
        case 0:
            ret = @"选项";
            break;
        default:
            break;
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = nil;
    
    if ([indexPath indexAtPosition:0] == 0) {
        if ([indexPath indexAtPosition:1] <=4)
            CellIdentifier = @"ConfigCell0";
        else if ([indexPath indexAtPosition:1] <= 6)
            CellIdentifier = @"ConfigCell1";
    } else if ([indexPath indexAtPosition:0] == 1)
        CellIdentifier = @"ConfigCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if ([indexPath indexAtPosition:0] == 1) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        } else {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
    }
    
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    cell.textLabel.text = @"列表字体大小";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d pt", (int)[ConfigManager defaultManager].listFontsize];
                    break;
                case 1:
                    cell.textLabel.text = @"文章内容字体大小";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d pt", (int)[ConfigManager defaultManager].articleFontsize];
                    break;
                case 2:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = @"网络连接超时";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d s", (int)[ConfigManager defaultManager].connectionTimeout];
                    break;
                case 3:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = @"热门话题显示数目";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)[ConfigManager defaultManager].popularAmount];
                    break;
                case 4:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = @"热门话题类型";
                    switch ([ConfigManager defaultManager].popularType) {
                        case 7:
                            cell.detailTextLabel.text = @"即时";
                            break;
                        case 180:
                            cell.detailTextLabel.text = @"今日";
                            break;
                        case 2520:
                            cell.detailTextLabel.text = @"本周";
                            break;
                        default:
                            break;
                    }
                    break;
                case 5:
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.text = @"显示版面置顶帖";
                    cell.accessoryView = [[[UISwitch alloc] init] autorelease];
                    ((UISwitch *)cell.accessoryView).on = [ConfigManager defaultManager].showTopArticles;
                    [(UISwitch *)cell.accessoryView addTarget:self action:@selector(showTopArticlesChanged:) forControlEvents:UIControlEventValueChanged];
                    break;
                case 6:
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.text = @"显示文章回帖";
                    cell.accessoryView = [[[UISwitch alloc] init] autorelease];
                    ((UISwitch *)cell.accessoryView).on = [ConfigManager defaultManager].showArticleReply;
                    [(UISwitch *)cell.accessoryView addTarget:self action:@selector(showArticleReplyChanged:) forControlEvents:UIControlEventValueChanged];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    cell.textLabel.text = @"恢复默认设置";
                    break;
                case 1:
                    cell.textLabel.text = @"清空版面收藏夹";
                    break;
                case 2:
                    cell.textLabel.text = @"关于本程序";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ValueSelector *vs = nil;
    OptionSelector *os = nil;
    UIActionSheet *sheet = nil;
    AboutViewController *avc = nil;
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        vs = [[ValueSelectorIPAD alloc] init];
                    else
                        vs = [[ValueSelector alloc] init];
                    vs.delegate = self;
                    vs.title = @"字体大小";
                    valueSelectorState = ValueSelectorStateListFontsize;
                    [self.navigationController pushViewController:vs animated:YES];
                    [vs release];
                    break;
                case 1:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        vs = [[ValueSelectorIPAD alloc] init];
                    else
                        vs = [[ValueSelector alloc] init];
                    vs.delegate = self;
                    vs.title = @"字体大小";
                    valueSelectorState = ValueSelectorStateArticleFontsize;
                    [self.navigationController pushViewController:vs animated:YES];
                    [vs release];
                    break;
                case 2:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        vs = [[ValueSelectorIPAD alloc] init];
                    else
                        vs = [[ValueSelector alloc] init];
                    vs.delegate = self;
                    vs.title = @"网络超时";
                    valueSelectorState = ValueSelectorStateConnectionTimeout;
                    [self.navigationController pushViewController:vs animated:YES];
                    [vs release];
                    break;
                case 3:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        vs = [[ValueSelectorIPAD alloc] init];
                    else
                        vs = [[ValueSelector alloc] init];
                    vs.delegate = self;
                    vs.title = @"热门话题数目";
                    valueSelectorState = ValueSelectorStatePopularAmount;
                    [self.navigationController pushViewController:vs animated:YES];
                    [vs release];
                    break;
                case 4:
                    os = [[OptionSelector alloc] init];
                    os.delegate = self;
                    optionSelectorState = OptionSelectorStatePopularType;
                    [self.navigationController pushViewController:os animated:YES];
                    [os release];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    actionSheetState = ActionSheetStateRestoreDefaults;
                    sheet = [[UIActionSheet alloc] initWithTitle:@"请确认操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确实要恢复默认设置？" otherButtonTitles:nil];
                    [sheet showFromTabBar:self.tabBarController.tabBar];
                    [sheet release];
                    break;
                case 1:
                    actionSheetState = ActionSheetStateClearFavorite;
                    sheet = [[UIActionSheet alloc] initWithTitle:@"请确认操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确实要清空版面收藏夹？" otherButtonTitles:nil];
                    [sheet showFromTabBar:self.tabBarController.tabBar];
                    [sheet release];
                    break;
                case 2:
                    avc = [[AboutViewController alloc] init];
                    [self.navigationController pushViewController:avc animated:YES];
                    [avc release];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
