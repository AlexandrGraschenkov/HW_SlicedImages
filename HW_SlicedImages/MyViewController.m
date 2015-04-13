//
//  MyViewController.m
//  HW_SlicedImages
//
//  Created by itisioslab on 20.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "MyViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyViewController() <UIScrollViewDelegate>
{
    CGFloat rowsCount;
    CGFloat columnsCount;
    CGFloat elemWidth;
    CGFloat elemHieght;
    NSArray *imagesArray;
}
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSizes];
    [self createArrayOfEmptyImages];
    [self loadImages];
    
    self.scrollView.delegate = self;
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

- (void)loadImages
{
    for (int i = 0; i < rowsCount; i++) {
        for (int j = 0; j < columnsCount; j++) {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", self.dict[@"folder_name"], i, j]];
            [imagesArray[i][j] sd_setImageWithURL:imageURL];
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mainView;
}

@end
