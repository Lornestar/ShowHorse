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
@synthesize imgHorse,imgNoImage,overlayViewController,capturedImages,lblHorse;


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
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *imgdata = [defaults dataForKey:@"imghorse"];
    if (imgdata){
        imgHorse.image = [UIImage imageWithData:imgdata];
        lblHorse.hidden = YES;
        imgNoImage.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    
    
    [self setImgNoImage:nil];
    [self setImgHorse:nil];
    [self setScrollvw:nil];
    [self setLblHorse:nil];
    [super viewDidUnload];
}

- (IBAction)btnCameraClicked:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)btnPhotoLibraryClicked:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (imgHorse.isAnimating)
        [imgHorse stopAnimating];
	
    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        
        
        //[[NSBundle mainBundle]  loadNibNamed:@"RegPapers" owner:self options:nil];
        overlayViewController =
        [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
        
        // as a delegate we will be notified when pictures are taken and when to dismiss the image picker
        overlayViewController.delegate = self;
        [overlayViewController setupImagePicker:sourceType];
        
        [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
    }
}

- (void)didTakePicture:(UIImage *)picture
{
    imgHorse.image = picture;
    
    lblHorse.hidden = YES;
    imgNoImage.hidden = YES;
    
    NSData *imgdata = UIImageJPEGRepresentation(picture, 100);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imgdata forKey:@"imghorse"];
    [defaults synchronize];
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
