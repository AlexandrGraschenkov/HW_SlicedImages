//
//  Cell.m
//  HW_SlicedImages
//
//  Created by Admin on 17.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "Cell.h"


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
