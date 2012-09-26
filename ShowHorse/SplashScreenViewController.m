//
//  SplashScreenViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-22.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end



@implementation SplashScreenViewController
@synthesize imgCover;
@synthesize vwSignUp;
@synthesize txtEmail,txtPassword,btnDoSignUp;
@synthesize lblHeader;

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
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"In ShowHorse" forKey:@"foo"];
    [testObject save];
    [super viewDidLoad];
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
    [super viewDidUnload];
    
    txtEmail.alpha = 0;
    txtPassword.alpha = 0;
    btnDoSignUp.alpha = 0;
}



- (void)opencover:(int)buttonid{
    [UIView beginAnimations:nil context:nil];
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
    }
    else{
        btnDoSignUp.titleLabel.text = @"Sign In";
        lblHeader.text = @"Sign In";
    }
    
    [UIView commitAnimations];
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
    
    if ([lblHeader.text isEqualToString:@"Sign Up"]){
        //Set username & pwd & check if legit email
        PFUser *user= [PFUser user];
        user.username = txtEmail.text;
        user.password = txtPassword.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error){
                //Saved successfully
                [self performSegueWithIdentifier:@"segueHorseImage" sender:nil];
            }
            else{
                //There's an error
                NSString *theerror = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:theerror delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        
    }
    else{
        //Check if legit username/pwd
        [PFUser logInWithUsernameInBackground:txtEmail.text password:txtPassword.text block:^(PFUser *user, NSError *error){
            if (user){
                //Successful Login
                [self performSegueWithIdentifier:@"segueToolBar" sender:nil];
            }
            else{
                //Login Failed
                NSString *theerror = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:theerror delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }
            
        }
         
         ];
        
        
    }

    
}

@end
