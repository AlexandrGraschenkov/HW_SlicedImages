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
    [self resizeView];
    
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize viewSize = self.scrollView.frame.size;
    viewSize.height -= self.scrollView.contentInset.top;
    self.scrollView.minimumZoomScale = MIN(viewSize.width / self.mainView.bounds.size.width, viewSize.height / self.mainView.bounds.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.zoomScale = MAX(self.scrollView.zoomScale, self.scrollView.minimumZoomScale);
    }];
    
    [self scrollViewDidZoom:self.scrollView];
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

- (void)resizeView
{
    CGRect frame =  CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, elemWidth * columnsCount, elemHieght*rowsCount);
    [self.mainView setFrame:frame];
    self.scrollView.contentSize = frame.size;
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
    
    CGRect frame = self.mainView.frame;
    frame.origin.x = hPadding;
    frame.origin.y = vPadding;
    self.mainView.frame = frame;
    // Иначе этот код ничего не делает. Ты вычисляешь смещение, а потом его не используешь.
    
    // Makes zoom out animation smooth and starting from the right point not from (0, 0)
    [self.view layoutIfNeeded];
}

@end
