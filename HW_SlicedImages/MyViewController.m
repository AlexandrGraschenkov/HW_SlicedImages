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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;

@end
@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSizes];
    [self createArrayOfEmptyImages];
    [self loadImages];
    
    self.scrollView.delegate = self;
    float minZoom = MIN(self.view.bounds.size.width / self.widthOfView.constant,
                        self.view.bounds.size.height / self.heightOfView.constant);
    self.scrollView.minimumZoomScale = (minZoom < 1) ? minZoom : 1;
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

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    float imageWidth = self.mainView.frame.size.width;
    float imageHeight = self.mainView.frame.size.height;
    
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    // center image if it is smaller than screen
    float hPadding = (viewWidth - imageWidth) / 2.0;
    if (hPadding < 0) hPadding = 0;
    
    float vPadding = (viewHeight - imageHeight) / 2.0;
    if (vPadding < 0) vPadding = 0;
    
    self.constraintLeft.constant = hPadding;
    self.constraintRight.constant = hPadding;
    self.constraintTop.constant = vPadding;
    self.constraintBottom.constant = vPadding;
    
    // Makes zoom out animation smooth and starting from the right point not from (0, 0)
    [self.view layoutIfNeeded];
}

@end
