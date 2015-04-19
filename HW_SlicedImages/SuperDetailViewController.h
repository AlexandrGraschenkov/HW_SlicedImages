//
//  SuperDetailViewController.h
//  HW_SlicedImages
//
//  Created by Евгений Сергеев on 16.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperDetailViewController : UIViewController
{
    CGFloat rowsCount;
    CGFloat columnsCount;
    CGFloat elementWidth;
    CGFloat elementHeight;
    NSArray *imgArr;
}

@property (nonatomic, strong) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
