//
//  TableCell.m
//  HW_SlicedImages
//
//  Created by itisioslab on 17.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "TableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface TableCell() <UIScrollViewDelegate>
{
    CGFloat rowsCount;
    CGFloat columnsCount;
    CGFloat elemWidth;
    CGFloat elemHieght;
    NSArray *imagesArray;
}
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *label;
@end

@implementation TableCell

- (void)setImg:(NSDictionary *)imgs
{
    _imgs = imgs;
    self.label.text = imgs[@""];
    NSURL *imgURL =[NSURL URLWithString:imgs[@""]];
    self.imgView.image = nil;
    [self.imgView sd_setImageWithURL: imgURL];
}

@end
