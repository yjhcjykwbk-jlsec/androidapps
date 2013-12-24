//
//  WMReaderAppDelegate.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-13.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "WMReaderAppDelegate.h"
#import "PopularViewController.h"
#import "BoardlistViewController.h"
#import "FavoriteViewController.h"
#import "ConfigViewController.h"
#import "Configuration/ConfigManager.h"

@implementation WMReaderAppDelegate


@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tabctrl = [[UITabBarController alloc] init];
    
    PopularViewController *popctrl = [[PopularViewController alloc] initWithStyle:UITableViewStylePlain];
    BoardlistViewController *brdctrl = [[BoardlistViewController alloc] initWithStyle:UITableViewStylePlain];
    FavoriteViewController *favctrl = [[FavoriteViewController alloc] initWithStyle:UITableViewStylePlain];
    ConfigViewController *confctrl = [[ConfigViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navpop, *navbrd, *navfav, *navconf;
    navpop = [[UINavigationController alloc] initWithRootViewController:popctrl];
    navbrd = [[UINavigationController alloc] initWithRootViewController:brdctrl];
    navfav = [[UINavigationController alloc] initWithRootViewController:favctrl];
    navconf = [[UINavigationController alloc] initWithRootViewController:confctrl];
    [popctrl release];
    [brdctrl release];
    [favctrl release];
    [confctrl release];
    
    tabctrl.viewControllers = [NSArray arrayWithObjects:navpop, navbrd, navfav, navconf, nil];
    [navpop release];
    [navbrd release];
    [navfav release];
    [navconf release];
    
    [self.window addSubview:tabctrl.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [[ConfigManager defaultManager] save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [self.window setNeedsDisplay];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [[ConfigManager defaultManager] save];
}

- (void)dealloc
{
    [tabctrl release];
    [window release];
    [super dealloc];
}

@end
