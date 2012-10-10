//
//  PerformancePopup.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-03.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "Performances.h"
#import "OverlayViewController.h"
#import "RegistrationPapers.h"

@interface PerformancePopup : UATitledModalPanel<UIImagePickerControllerDelegate,OverlayViewControllerDelegate> {
    UIView			*v;
	IBOutlet UIView	*viewLoadedFromXib;
    IBOutlet UIView *viewLoadedFromXibRegPapers;
}

@property (weak, nonatomic) IBOutlet UITextField *txteventdate;
@property (weak, nonatomic) IBOutlet UITextField *txteventname;
@property (weak, nonatomic) IBOutlet UITextField *txtclassdescription;
@property (weak, nonatomic) IBOutlet UITextField *txtplacing;
@property (weak, nonatomic) IBOutlet UITextField *txtjudge;
@property (weak, nonatomic) IBOutlet UITextField *txtcompetitors;
@property (weak, nonatomic) IBOutlet UITextField *txtscore;

@property (strong, nonatomic) Performances *globalPerformanceObject;
@property (strong, nonatomic) UIImage *globalPhoto;
@property (strong, nonatomic) RegistrationPapers *globalRegPapersObject;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title PerformanceObject:(Performances*)PerformanceObject nibid:(int)nibid RegPapersObject:(RegistrationPapers*)RegPapersObject;
- (IBAction)btnSavePerformanceClicked:(id)sender;
- (IBAction)txtEditFieldDone:(id)sender;
- (IBAction)txtEditFieldTouch:(id)sender;


- (IBAction)btnSaveClick:(id)sender;
- (IBAction)btnPhotoLibraryClick:(id)sender;
- (IBAction)btnTakePhotoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *RegPapersImage;
@property (nonatomic, retain) NSMutableArray *capturedImages;
@property (nonatomic, retain) OverlayViewController *overlayViewController;
@property (weak, nonatomic) IBOutlet UIButton *btnSavePhoto;

@end
