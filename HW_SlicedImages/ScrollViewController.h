//
//  ScrollViewController.h
//  HW_SlicedImages
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "URLList.h"

@interface ScrollViewController : ViewController
@property URLList *urlObject;
@property (nonatomic, strong) UIView *imagesView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end