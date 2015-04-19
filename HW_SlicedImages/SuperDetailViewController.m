//
//  SuperDetailViewController.m
//  HW_SlicedImages
//
//  Created by Евгений Сергеев on 16.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "SuperDetailViewController.h"
#import <UIImageView+WebCache.h>

@implementation SuperDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(800, 500)];
    
    [self instanceSizes];
    [self createArrayOfEmptyImages];
    [self loadingImages];
    
    self.scrollView.minimumZoomScale=0.0;
    self.scrollView.maximumZoomScale=6.0;
}

- (void)instanceSizes
{
    rowsCount = [self.dict[@"rows_count"] floatValue];
    columnsCount = [self.dict[@"columns_count"] floatValue];
    elementWidth = [self.dict[@"elem_width"] floatValue];
    elementHeight = [self.dict[@"elem_height"] floatValue];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mainView;
}

- (void)createArrayOfEmptyImages
{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < rowsCount; i++) {
        NSMutableArray *elementsInRow = [NSMutableArray new];
        for (int j = 0; j < columnsCount; j++) {
            CGRect frame = CGRectMake(j * elementWidth, i * elementHeight, elementWidth, elementHeight);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
            [self.mainView addSubview:imgView];
            [elementsInRow addObject:imgView];
        }
        [arr addObject:elementsInRow];
    }
    imgArr = [arr copy];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)loadingImages
{
    for (int i = 0; i < rowsCount; i++) {
        for (int j = 0; j < columnsCount; j++) {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", self.dict[@"folder_name"], i, j]];
            [imgArr[i][j] sd_setImageWithURL:imageURL];
        }
    }
}

@end
