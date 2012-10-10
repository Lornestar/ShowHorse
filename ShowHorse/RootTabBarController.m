//
//  RootTabBarController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-26.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "RootTabBarController.h"
#import "AppDelegate.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController
@synthesize tbRoot;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    [appdel initRecords];
    [appdel initPerformances];
    [appdel initPapers];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    tbRoot.backgroundImage = [UIImage imageNamed:@"ToolBar_Background.png"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTbRoot:nil];
    [super viewDidUnload];
}
@end
