//
//  ImageViewContr.m
//  HW_SlicedImages
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 ITIS. All rights reserved.
//

#import "ImageViewContr.h"
#import <UIImageView+WebCache.h>

@implementation ImageViewContr

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSizes];
    [self createArrayOfEmptyImages];
    [self loadImages];
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
}

- (void)setupSizes
{
    rowsCount = [self.dict[@"rows_count"] floatValue];
    columnsCount = [self.dict[@"columns_count"] floatValue];
    elemWidth = [self.dict[@"elem_width"] floatValue];
    elemHieght = [self.dict[@"elem_height"] floatValue];
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
            CGRect frame = CGRectMake(j * elemWidth, i * elemHieght, elemWidth, elemHieght);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
            [self.mainView addSubview:imgView];
            [elementsInRow addObject:imgView];
        }
        [arr addObject:elementsInRow];
    }
    imagesArray = [arr copy];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)loadImages
{
    for (int i = 0; i < rowsCount; i++) {
        for (int j = 0; j < columnsCount; j++) {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", self.dict[@"folder_name"], i, j]];
            [imagesArray[i][j] sd_setImageWithURL:imageURL];
        }
    }
}

@end
