//
//  FolderCell.m
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "FolderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NetManager.h"

@interface FolderCell(){}
@property (nonatomic, weak) IBOutlet UILabel *label;
@end


@implementation FolderCell
-(void)setFolder:(NSDictionary *)folder{
    _folder = folder;
    NSString *fName = folder[@"folder_name"];
    self.label.text = fName;
}
@end
