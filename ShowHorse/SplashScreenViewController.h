//
//  SplashScreenViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-22.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface SplashScreenViewController : UIViewController<MBProgressHUDDelegate>{

MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgCover;
@property (weak, nonatomic) IBOutlet UIView *vwSignUp;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnDoSignUp;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@property (weak, nonatomic) IBOutlet UIButton *btnSignin;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *gstCoverDown;

- (IBAction)btnDoEnter:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnSignIn:(id)sender;
- (IBAction)btnDoSignUp:(id)sender;
- (IBAction)backgroundtouch:(id)sender;
- (IBAction)txtEmailNext:(id)sender;
- (IBAction)txtPasswordGo:(id)sender;
- (IBAction)gstCoverDownClick2:(id)sender;


@end
