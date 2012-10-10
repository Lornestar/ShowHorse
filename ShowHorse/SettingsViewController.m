//
//  SettingsViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()
@property (nonatomic) AppDelegate *appdel;
@end

@implementation SettingsViewController
@synthesize lblUsername,appdel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appdel = [UIApplication sharedApplication].delegate;
    lblUsername.text = appdel.userinfo.Username;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogoutClicked:(id)sender {
    [appdel logoutVariables];
    [self performSegueWithIdentifier:@"seguelogout" sender:self];
}


- (void)viewDidUnload {
    [self setLblUsername:nil];
    [super viewDidUnload];
}
@end
