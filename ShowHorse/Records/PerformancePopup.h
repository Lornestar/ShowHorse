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

- (IBAction)txtEditFieldDone:(id)sender;
- (IBAction)txtEditFieldTouch:(id)sender;
- (IBAction)btnSavePerformanceClicked:(id)sender;
- (IBAction)btnDeletePerformanceClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnDeletePerformance;


- (IBAction)btnSaveClick:(id)sender;
- (IBAction)btnPhotoLibraryClick:(id)sender;
- (IBAction)btnTakePhotoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *RegPapersImage;
@property (nonatomic, retain) NSMutableArray *capturedImages;
@property (nonatomic, retain) OverlayViewController *overlayViewController;
@property (weak, nonatomic) IBOutlet UIButton *btnSavePhoto;
- (IBAction)btnSelectDateClick:(id)sender;
- (IBAction)btnCancelClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vwtheDatePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *thedatepicker;

@property (strong,nonatomic) NSDate *chosendate;
@property (strong,nonatomic) NSDateFormatter *df;
- (IBAction)txteventdateeditingbegin:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnFullScreen;
- (IBAction)btnFullScreenClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblAddPhoto;

@end
