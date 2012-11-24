//
//  SettingsViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayViewController.h"

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate>

- (IBAction)btnCameraClicked:(id)sender;
- (IBAction)btnPhotoLibraryClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgNoImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgHorse;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollvw;
@property (strong, nonatomic) IBOutlet UILabel *lblHorse;

@property (nonatomic, retain) NSMutableArray *capturedImages;
@property (nonatomic, retain) OverlayViewController *overlayViewController;
@end
