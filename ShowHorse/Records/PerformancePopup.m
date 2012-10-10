//
//  PerformancePopup.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-03.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "PerformancePopup.h"
#import "Performances.h"
#import "RecordsViewController.h"
#import "RegistrationPapers.h"
#import <QuartzCore/QuartzCore.h>

#define BLACK_BAR_COMPONENTS				{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }

@implementation PerformancePopup

@synthesize txteventdate,txteventname,txtclassdescription,txtplacing,txtjudge,txtcompetitors,txtscore,globalPerformanceObject,RegPapersImage,overlayViewController,btnSavePhoto,globalPhoto,globalRegPapersObject;


- (id)initWithFrame:(CGRect)frame title:(NSString *)title PerformanceObject:(Performances*)PerformanceObject nibid:(int)nibid RegPapersObject:(RegistrationPapers*)RegPapersObject{
	if ((self = [super initWithFrame:frame])) {
		
		CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
		self.headerLabel.text = title;
        
        btnSavePhoto.layer.cornerRadius =9.0;
        btnSavePhoto.layer.masksToBounds = YES;
        btnSavePhoto.layer.borderColor = [UIColor blackColor].CGColor;
        btnSavePhoto.layer.borderWidth = 3;
        CGRect frame = btnSavePhoto.frame;
        frame.size.width = 100;
        frame.size.height = 100;
        btnSavePhoto.frame = frame;
		
		////////////////////////////////////
		// RANDOMLY CUSTOMIZE IT
		////////////////////////////////////
		// Show the defaults mostly, but once in awhile show a completely random funky one
		//if (arc4random() % 4 == 0) {
			// Funky time.
			//UADebugLog(@"Showing a randomized panel for modalPanel: %@", self);
			
			// Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
			//self.margin = UIEdgeInsetsMake(((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f);
			
			// Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
			//self.padding = UIEdgeInsetsMake(((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f, ((arc4random() % 4) + 1) * 20.0f);
			
			// Border color of the panel. Default = [UIColor whiteColor]
			//self.borderColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
			
			// Border width of the panel. Default = 1.5f;
			//self.borderWidth = ((arc4random() % 21)) * 0.5f;
			
			// Corner radius of the panel. Default = 4.0f
			//self.cornerRadius = (arc4random() % 21);
			
			// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
			//self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
			
			// Shows the bounce animation. Default = YES
			//self.shouldBounce = (arc4random() % 2);
			
			// Shows the actionButton. Default title is nil, thus the button is hidden by default
			//[self.actionButton setTitle:@"Foobar" forState:UIControlStateNormal];
            
			// Height of the title view. Default = 40.0f
			//[self setTitleBarHeight:((arc4random() % 5) + 2) * 20.0f];
            
			
			// The background color gradient of the title
			//CGFloat colors[8] = {
			//	(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1,
			//	(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1
			//};
			//[[self titleBar] setColorComponents:colors];
			
			// The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = UAGradientBackgroundStyleLinear
			//[[self titleBar] setGradientStyle:(arc4random() % 5)];
			
			// The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
			//[[self titleBar] setLineMode: pow(2, (arc4random() % 3))];
			
			// The noise layer opacity. Default = 0.4
			//[[self titleBar] setNoiseOpacity:(((arc4random() % 10) + 1) * 0.1)];
			
			// The header label, a UILabel with the same frame as the titleBar
			//[self headerLabel].font = [UIFont boldSystemFontOfSize:floor(self.titleBarHeight / 2.0)];
		//}
        
        
		//////////////////////////////////////
		// SETUP RANDOM CONTENT
		//////////////////////////////////////
		/*UIWebView *wv = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
		[wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://urbanapps.com/product_list"]]];
		
		UITableView *tv = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
		[tv setDataSource:self];
		
		UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		[iv setImage:[UIImage imageNamed:@"UrbanApps.png"]];
		[iv setContentMode:UIViewContentModeScaleAspectFit];
		
		[[NSBundle mainBundle] loadNibNamed:@"UAExampleView" owner:self options:nil];
		
		NSArray *contentArray = [NSArray arrayWithObjects:wv, tv, iv, viewLoadedFromXib, nil];
		
		int i = arc4random() % [contentArray count];
		v = [[contentArray objectAtIndex:i] retain];
		[self.contentView addSubview:v];*/
        
        if (nibid == 0){
            [self setTitleBarHeight:30];
            [self headerLabel].font = [UIFont boldSystemFontOfSize:20];
            self.margin = UIEdgeInsetsMake(15, 15, 15, 15);
            self.padding = UIEdgeInsetsMake(5, 5, 5, 5);
            
            //Performances
            [[NSBundle mainBundle]  loadNibNamed:@"UAExampleView" owner:self options:nil];
            [self.contentView addSubview:viewLoadedFromXib];
            
            
            if (PerformanceObject){
                //Existing performance object
                txteventdate.text = [NSString stringWithFormat:@"%@", PerformanceObject.Date];
                txteventname.text = PerformanceObject.Name;
                txtclassdescription.text = PerformanceObject.Description;
                txtplacing.text = PerformanceObject.Placing;
                txtjudge.text = PerformanceObject.Judge;
                txtcompetitors.text = PerformanceObject.Competitors;
                txtscore.text = PerformanceObject.Score;
                globalPerformanceObject = PerformanceObject;
            }
        }
        else if (nibid ==1){
            [self setTitleBarHeight:15];
            [self headerLabel].font = [UIFont boldSystemFontOfSize:20];
            self.margin = UIEdgeInsetsMake(15, 15, 0, 15);
            self.padding = UIEdgeInsetsMake(5, 5, 5, 5);
            
            //Reg Papers
            [[NSBundle mainBundle]  loadNibNamed:@"RegPapers" owner:self options:nil];
            [self.contentView addSubview:viewLoadedFromXibRegPapers];
         
            self.capturedImages = [NSMutableArray array];
            
            
            if (RegPapersObject){
                globalRegPapersObject = RegPapersObject;
                RegPapersImage.image = globalRegPapersObject.Papers;
                
                
                
                btnSavePhoto.backgroundColor = [UIColor redColor];
                [btnSavePhoto setTitle:@"Delete" forState:UIControlStateNormal];
                [btnSavePhoto setTitle:@"Delete" forState:UIControlStateHighlighted];
                [btnSavePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnSavePhoto setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                
            }
            else{
                globalRegPapersObject = [[RegistrationPapers alloc]init];
                btnSavePhoto.hidden = YES;
            }
        }
        
	}	
	return self;
}

- (IBAction)btnSavePerformanceClicked:(id)sender{
    //NSLog(@"btnsaveperformanceclicked");
    // Maybe the delegate wants something to do with it...
    Performances *tempperf;
    if (globalPerformanceObject){
        tempperf = globalPerformanceObject;
    }
    else{
        tempperf = [[Performances alloc] init];
    }
	 
    tempperf.Date = [NSDate date];
    tempperf.Name = txteventname.text;
    tempperf.Description = txtclassdescription.text;
    tempperf.Placing = txtplacing.text;
    tempperf.Judge = txtjudge.text;
    tempperf.Competitors = txtcompetitors.text;
    tempperf.Score = txtscore.text;
    
    if ([delegate respondsToSelector:@selector(AddPerformance:)]) {
		[delegate performSelector:@selector(AddPerformance:) withObject:tempperf];
        [self hide];
        // Or perhaps someone is listening for notifications
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"SuperAwesomeButtonPressed" object:sender];
	}
}

- (IBAction)txtEditFieldDone:(id)sender{
    /*UITextField *txtfield = (UITextField*)sender;
    if ([txtfield.placeholder isEqualToString:@"Event Date"]){
            //move next
            [self MoveView:300];
            [txteventname becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"Event Name"]){
        //move next
        [self MoveView:270];
        [txtclassdescription becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"Class Description"]){
        //move next
        [self MoveView:240];
        [txtplacing becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"Placing"]){
        //move next
        [self MoveView:210];
        [txtjudge becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"Judge Name"]){
        //move next
        [self MoveView:180];
        [txtcompetitors becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"No. Competitors"]){
        //move next
        [self MoveView:150];
        [txtscore becomeFirstResponder];
    }
    else if ([txtfield.placeholder isEqualToString:@"Score"]){
        //move next
        [self MoveView:330];
        [txtscore resignFirstResponder];
    }*/
    
    [self MoveView:330];
    [txtscore resignFirstResponder];
}

- (IBAction)txtEditFieldTouch:(id)sender {
    UITextField *txtfield = (UITextField*)sender;
    if ([txtfield.placeholder isEqualToString:@"Event Date"]){
        //move next
        [self MoveView:330];
       
    }
    else if ([txtfield.placeholder isEqualToString:@"Event Name"]){
        //move next
        [self MoveView:300];
      }
    else if ([txtfield.placeholder isEqualToString:@"Class Description"]){
        //move next
        [self MoveView:270];
        
    }
    else if ([txtfield.placeholder isEqualToString:@"Placing"]){
        //move next
        [self MoveView:240];
        
    }
    else if ([txtfield.placeholder isEqualToString:@"Judge Name"]){
        //move next
        [self MoveView:210];
        
    }
    else if ([txtfield.placeholder isEqualToString:@"No. Competitors"]){
        //move next
        [self MoveView:180];
        
    }
    else if ([txtfield.placeholder isEqualToString:@"Score"]){
        //move next
        [self MoveView:150];
    }

}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (RegPapersImage.isAnimating)
        [RegPapersImage stopAnimating];
	
    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        RecordsViewController *rvc = delegate;
    
        //[[NSBundle mainBundle]  loadNibNamed:@"RegPapers" owner:self options:nil];
        overlayViewController =
        [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
        
        // as a delegate we will be notified when pictures are taken and when to dismiss the image picker
        overlayViewController.delegate = self;
        [overlayViewController setupImagePicker:sourceType];

        [rvc presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
    }
}


- (IBAction)btnSaveClick:(id)sender {
    
    if ([btnSavePhoto.titleLabel.text isEqualToString:@"Delete"]){
        //Delete Photo
        if ([delegate respondsToSelector:@selector(DeleteRegPapers:)]) {
            [delegate performSelector:@selector(DeleteRegPapers:) withObject:globalRegPapersObject];
            [self hide];
            // Or perhaps someone is listening for notifications
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveRegPapersClicked" object:sender];
        }
    }
    else{
        //Save Photo
        
        if ([delegate respondsToSelector:@selector(AddRegPapers:)]) {
            [delegate performSelector:@selector(AddRegPapers:) withObject:globalRegPapersObject];
            [self hide];
            // Or perhaps someone is listening for notifications
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveRegPapersClicked" object:sender];
        }
    }
    
}

- (IBAction)btnPhotoLibraryClick:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)btnTakePhotoClick:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}







-(void) MoveView:(CGFloat)they{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    viewLoadedFromXib.center = CGPointMake(140, they);
    
    [UIView commitAnimations];
}

- (void)didTakePicture:(UIImage *)picture
{
    RegPapersImage.image = picture;
    globalRegPapersObject.Papers = RegPapersImage.image;
    btnSavePhoto.hidden = NO;
    [btnSavePhoto setBackgroundColor:[UIColor blueColor]];
    [btnSavePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSavePhoto setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btnSavePhoto setTitle:@"Save" forState:UIControlStateNormal];
    [btnSavePhoto setTitle:@"Save" forState:UIControlStateHighlighted];
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    RecordsViewController *rvc = delegate;
    [rvc dismissModalViewControllerAnimated:YES];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
