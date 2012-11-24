//
//  ImageViewerScrollView.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-21.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "ImageViewerScrollView.h"

@implementation ImageViewerScrollView

@synthesize imageView;

#pragma mark - Memory Management


#pragma mark - Initialisation

- (id)initWithImageNamed:(UIImage *)theimage atLocation:(CGPoint)location {
    self = [super init];
    if (self) {
        // Assign the delegate
        self.delegate = self;
        
        // Create our image view using the passed in image name
        self.imageView = [[UIImageView alloc] initWithImage:theimage];
        
        // Update the ImageZoom frame to match the dimensions of passed in image
        self.frame = CGRectMake(location.x, location.y,
                                self.imageView.frame.size.width, self.imageView.frame.size.height);
        
        // Set a default minimum and maximum zoom scale
        self.minimumZoomScale = 0.5f;
        self.maximumZoomScale = 3.0f;
        
        // Add image view as a subview
        [self addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - UIScrollViewDelegates

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


@end
