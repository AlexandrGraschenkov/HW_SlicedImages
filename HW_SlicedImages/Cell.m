//
//  Cell.m
//  HW_SlicedImages
//
//  Created by Михаил on 14.05.15.
//  Copyright (c) 2015 Михаил. All rights reserved.
//

#import "Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NetManager.h"

@interface Cell(){}
@property (nonatomic, weak) IBOutlet UILabel *label;
@end


@implementation Cell
-(void)setFolder:(NSDictionary *)folder{
    _folder = folder;
    NSString *fName = folder[@"folder_name"];
    self.label.text = fName;
}
@end
