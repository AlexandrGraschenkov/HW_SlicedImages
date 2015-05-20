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
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", self.imgs[@"folder_name"]]];
    [self.imgView sd_setImageWithURL: imageURL];
}

@end
