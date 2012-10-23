//
//  SplashScreenViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-22.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface SplashScreenViewController ()

@end



@implementation SplashScreenViewController
@synthesize imgCover;
@synthesize vwSignUp;
@synthesize txtEmail,txtPassword,btnDoSignUp;
@synthesize lblHeader;
@synthesize btnSignin, btnSignup, gstCoverDown;

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
    
    
    [super viewDidLoad];
    
    txtEmail.alpha = 0;
    txtPassword.alpha = 0;
    btnDoSignUp.alpha = 0;
    //txtEmail.text = @"lorne@lornestar.com";
    //txtPassword.text = @"1234";
    gstCoverDown.enabled = NO;
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    if (appdel.userinfo){
        [self performSegueWithIdentifier:@"segueHorseImage" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgCover:nil];
    [self setVwSignUp:nil];
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [self setBtnDoSignUp:nil];
    [self setLblHeader:nil];
    [self setBtnSignup:nil];
    [self setBtnSignin:nil];
    [self setGstCoverDown:nil];
    [super viewDidUnload];
    
    
}

-(void)opencoverfinished{
    [txtEmail becomeFirstResponder];
}


- (void)opencover:(int)buttonid{
    [UIView beginAnimations:@"opencover" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(opencoverfinished)];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0.25];
    
    imgCover.center = CGPointMake(imgCover.center.x, -80);
    txtEmail.alpha = 1;
    txtPassword.alpha = 1;
    //btnDoSignUp.alpha = 1;
    lblHeader.alpha = 1;
    
    
    if (buttonid == 0){
        btnDoSignUp.titleLabel.text = @"Sign Up";
        lblHeader.text = @"Sign Up";
        btnSignin.alpha = 0;
    }
    else{
        btnDoSignUp.titleLabel.text = @"Sign In";
        lblHeader.text = @"Sign In";
        btnSignup.alpha = 0;
    }
    
    [UIView commitAnimations];
    gstCoverDown.enabled = YES;
    
    
    
}

- (IBAction)btnSignUp:(id)sender {
    [self opencover:0];
}

- (IBAction)btnSignIn:(id)sender {
    [self opencover:1];
}

- (IBAction)btnDoSignUp:(id)sender {
    if ([btnDoSignUp.titleLabel.text isEqualToString:@"Sign Up"]){
        //Do Sign Up
    }
    else{
        //Do Sign In
    }
}

- (IBAction)backgroundtouch:(id)sender {
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}

- (IBAction)txtEmailNext:(id)sender {
    [txtPassword becomeFirstResponder];
}

- (IBAction)txtPasswordGo:(id)sender {
    
    [txtPassword resignFirstResponder];
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    if ([lblHeader.text isEqualToString:@"Sign Up"]){
        //Set username & pwd & check if legit email
        PFUser *user= [PFUser user];
        user.username = txtEmail.text;
        user.password = txtPassword.text;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = @"Signing Up";
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error){
                //Saved successfully
                [appdel initUser:user.username userid:user.objectId];
                [self performSegueWithIdentifier:@"segueHorseImage" sender:nil];
            }
            else{
                //There's an error
                NSString *theerror = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:theerror delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
        
    }
    else{
        //Check if legit username/pwd
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = @"Signing In";
        [PFUser logInWithUsernameInBackground:txtEmail.text password:txtPassword.text block:^(PFUser *user, NSError *error){
            if (user){
                //Successful Login
                sleep(1);
                [appdel initUser:user.username userid:user.objectId];
                [self performSegueWithIdentifier:@"segueToolBar" sender:nil];
            }
            else{
                //Login Failed
                NSString *theerror = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:theerror delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            
        }
         
         ];
        
        
    }
    
    
}


- (IBAction)gstCoverDownClick2:(id)sender {
    UIGestureRecognizer *gsttemp = (UIGestureRecognizer*)sender;
    CGPoint location = [gsttemp locationInView:self.view];
    if (location.y < 150){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelay:0.25];
        
        imgCover.center = CGPointMake(imgCover.center.x, 206);
        txtEmail.alpha = 0;
        txtPassword.alpha = 0;
        lblHeader.alpha = 0;
        btnDoSignUp.alpha = 0;
        btnSignup.alpha = 1;
        btnSignin.alpha = 1;
        
        [txtEmail resignFirstResponder];
        [txtPassword resignFirstResponder];
        [UIView commitAnimations];
        gstCoverDown.enabled = NO;
    }
    
    
}



@end
