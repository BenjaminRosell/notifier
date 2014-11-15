//
//  YYYViewController.m
//  WrapperParse
//
//  Created by BestDev on 11/15/14.
//  Copyright (c) 2014 BestDev. All rights reserved.
//

#import "YYYViewController.h"

@interface YYYViewController ()

@end

@implementation YYYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadURL:) name:@"LoadUrl" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)loadURL:(NSNotification*)notification
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",notification.object] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	
	NSDictionary *result = [NSJSONSerialization JSONObjectWithData: [[[notification.object objectForKey:@"aps"] objectForKey:@"alert"]			 dataUsingEncoding:NSUTF8StringEncoding]	options: NSJSONReadingMutableContainers error: nil];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[result objectForKey:@"url"]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
