//
//  RecordsImageViewerViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-20.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "RecordsImageViewerViewController.h"
#import "ImageViewerScrollView.h"

@interface RecordsImageViewerViewController ()

@end

@implementation RecordsImageViewerViewController
@synthesize imgRecords,globalImgRecords,imgviewscroller;

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
    imgRecords.image = globalImgRecords;
    //imgviewscroller = [[ImageViewerScrollView alloc]initWithImageNamed:globalImgRecords atLocation:CGPointMake(0, 0)];
    //ImageViewerScrollView *imgscrl = [[ImageViewerScrollView alloc]initWithImageNamed:globalImgRecords atLocation:CGPointMake(0, 0)];
    //[self.view addSubview:imgscrl];
    imgviewscroller.minimumZoomScale = 0.5f;
    imgviewscroller.maximumZoomScale = 3.0f;
    imgviewscroller.delegate = self;
    imgviewscroller.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegates

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgRecords;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgRecords:nil];
    [self setImgviewscroller:nil];
    [super viewDidUnload];
}

-(void)insertimage:(UIImage*)imagetobeviewed
{
    globalImgRecords = imagetobeviewed;
}

- (IBAction)btnBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
