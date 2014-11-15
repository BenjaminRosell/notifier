//
//  YYYAppDelegate.m
//  WrapperParse
//
//  Created by BestDev on 11/15/14.
//  Copyright (c) 2014 BestDev. All rights reserved.
//

#import "YYYAppDelegate.h"

#define PP_APPID		@"KVoYpkSprEY327cemJecUFQp8Vs6EbaczduSOpGp"
#define PP_CLIENTKEY	@"e12VLaaVzUfjFRGOMJ9HJ2d1ppHHk75zHhJIZLLc"

@implementation YYYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
	if (launchOptions)
		[self performSelector:@selector(loadURL:) withObject:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] afterDelay:1.0];
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	
	[Parse setApplicationId:PP_APPID  clientKey:PP_CLIENTKEY];
	[application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
	
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
	{
		//ios 8
		[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
		[[UIApplication sharedApplication] registerForRemoteNotifications];
	}
	else
	{
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound)];
	}
	
    return YES;
}

-(void)loadURL:(id)object
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoadUrl" object:object];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	[currentInstallation setDeviceTokenFromData:deviceToken];
	[currentInstallation saveInBackground];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
	NSLog(@"Failed to get token, error : %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoadUrl" object:userInfo];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
