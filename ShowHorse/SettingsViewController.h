//
//  SettingsViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

- (IBAction)btnLogoutClicked:(id)sender;

@end
