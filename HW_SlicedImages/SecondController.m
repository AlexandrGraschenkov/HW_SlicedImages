//
//  SecondController.m
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 25.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "SecondController.h"
#import "NetManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImageManager.h>

@interface SecondController () <UIScrollViewDelegate> {
  
}
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat rows;
@property (nonatomic) CGFloat columns;
@property (nonatomic, strong) UIScrollView *scrollViewPointer;
@property (nonatomic, strong) UIView *contentViewPointer;
@property (nonatomic, strong) NSDictionary *viewsDictionary;
@property (nonatomic, strong) NSDictionary *contentDict;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic) NSString *name;
@end

@implementation SecondController
@synthesize folder;
-(void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView addSubview:contentView];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollViewPointer = scrollView;
    self.contentViewPointer = contentView;
    [self setSizes];
    scrollView.maximumZoomScale = 4.0;
    scrollView.minimumZoomScale = MIN(self.view.bounds.size.width / (self.width*self.columns),
                                      self.view.bounds.size.height / (self.height*self.rows));
    scrollView.delegate = self;
    [self getImageGrid];
    [self fillGrid];
}

-(void)setSizes{
    self.rows = [self.folder[@"rows_count"] floatValue];
    self.columns = [self.folder[@"columns_count"] floatValue];
    self.width = [self.folder[@"elem_width"] floatValue];
    self.height = [self.folder[@"elem_height"] floatValue];
    self.name = self.folder[@"folder_name"];
    
    self.viewsDictionary = NSDictionaryOfVariableBindings(_scrollViewPointer, _contentViewPointer);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollViewPointer]|" options:0 metrics: 0 views:_viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollViewPointer]|" options:0 metrics: 0 views:_viewsDictionary]];
    
    [_scrollViewPointer addConstraint:[NSLayoutConstraint
                              constraintWithItem:_scrollViewPointer
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:_contentViewPointer
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                              constant:0.0]];
    
    [_scrollViewPointer addConstraint:[NSLayoutConstraint
                                       constraintWithItem:_contentViewPointer
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_scrollViewPointer
                                       attribute:NSLayoutAttributeLeading
                                       multiplier:1.0
                                       constant:0.0]];
    [_scrollViewPointer addConstraint:[NSLayoutConstraint
                                       constraintWithItem:_contentViewPointer
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_scrollViewPointer
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.0
                                       constant:0.0]];
    [_scrollViewPointer addConstraint:[NSLayoutConstraint
                                       constraintWithItem:_scrollViewPointer
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_contentViewPointer
                                       attribute:NSLayoutAttributeBottom
                                       multiplier:1.0
                                       constant:0.0]];

    self.contentDict = @{@"content":_contentViewPointer};
    NSString *contentWidth = [NSString stringWithFormat:@"H:[content(%f)]",self.width*self.columns];
    NSString *contentHeight = [NSString stringWithFormat:@"V:[content(%f)]",self.height*self.rows];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:contentWidth options:0 metrics:nil views:_contentDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:contentHeight options:0 metrics:nil views:_contentDict]];
}

-(void)getImageGrid{
    NSMutableArray *imageGrid = [[NSMutableArray alloc] initWithCapacity:self.rows];
    NSMutableArray *tempRow = [[NSMutableArray alloc] initWithCapacity:self.columns];
    for (int i=0; i<self.rows; i++) {
        [tempRow removeAllObjects];
        for (int j=0; j<self.columns; j++) {
            CGRect pieceOfPic = CGRectMake(j * self.width, i * self.height, self.width, self.height);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:pieceOfPic];
            [_contentViewPointer addSubview:imgView];
            [tempRow addObject:imgView];
        }
        [imageGrid insertObject:[NSArray arrayWithArray:tempRow] atIndex:i];
    }
    self.pic = [imageGrid copy];
}
-(void)fillGrid{
    for (int i=0; i<self.rows; i++) {
        for (int j=0; j<self.columns; j++) {
            NSString *strURL = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png",self.name,i,j];
            NSURL *imgURL = [NSURL URLWithString:strURL];
            [[[self.pic objectAtIndex:i] objectAtIndex:j] sd_setImageWithURL:imgURL];
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self changeConstantsOfConstraints];
}
-(void)changeConstantsOfConstraints{
    float contentWidth = _contentViewPointer.frame.size.width;
    float contentHeight = _contentViewPointer.frame.size.height;
    
    float superviewWidth = self.view.bounds.size.width;
    float superviewHeight = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    float hPadding = (superviewWidth - contentWidth) / 2.0;
    if (hPadding < 0) hPadding = 0;
    
    float vPadding = (superviewHeight - contentHeight) / 2.0;
    if (vPadding < 0) vPadding = 0;
    
    for(NSLayoutConstraint *constraint in _scrollViewPointer.constraints)
    {
        if (constraint.firstAttribute == 6 || constraint.firstAttribute == 5) {
            constraint.constant = hPadding;
        } else if (constraint.firstAttribute == 3 || constraint.firstAttribute == 4) {
            constraint.constant = vPadding;
        }
    }
    [self.view layoutIfNeeded];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    [self changeConstantsOfConstraints];
}

@end
