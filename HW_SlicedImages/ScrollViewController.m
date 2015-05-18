//
//  ScrollViewController.m
//  HW_SlicedImages
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ScrollViewController.h"
#import "URLList.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ScrollViewController() <UIScrollViewDelegate>

@end

@implementation ScrollViewController
@synthesize scrollView;

-(void)viewDidLoad {
    [super viewDidLoad];
    CGSize newSize = CGSizeMake(self.urlObject.width.floatValue * self.urlObject.columnQuantity.floatValue,
                                self.urlObject.height.floatValue * self.urlObject.rowQuantity.floatValue);
    [scrollView setContentSize:newSize];
    [scrollView.inputAccessoryView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:scrollView];
    
    self.imagesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newSize.width, newSize.height)];
    [scrollView addSubview:self.imagesView];
    
    for (int j=0; j<self.urlObject.rowQuantity.intValue; j++) {
        for (int i=0; i < self.urlObject.columnQuantity.intValue; i++) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png",self.urlObject.name,j,i]];
            CGRect frame = CGRectMake(self.urlObject.width.intValue * i, self.urlObject.height.intValue * j,
                                      self.urlObject.width.intValue, self.urlObject.height.intValue);
            
            UIImageView *imgView = [UIImageView new];
            [imgView sd_setImageWithURL:url];
            [imgView setFrame:frame];
            [self.imagesView addSubview:imgView];
        }
    }
    
    self.scrollView.minimumZoomScale=MIN(0.99,([scrollView superview].frame.size.width / self.imagesView.frame.size.width));
    self.scrollView.maximumZoomScale=1.0;
    self.scrollView.delegate = self;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.scrollView.minimumZoomScale=MIN(0.99,([scrollView superview].frame.size.width / self.imagesView.frame.size.width));
    [self centerScrollViewContents];
}

#pragma mark - UIScrollViewDelegate protocol methods

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imagesView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imagesView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.imagesView setFrame:contentsFrame];
    }];
}
@end
