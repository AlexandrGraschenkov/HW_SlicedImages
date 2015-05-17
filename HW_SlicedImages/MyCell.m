//
//  MyCell.m
//  HW_SlicedImages
//
//  Created by Admin on 16.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "MyCell.h"

@interface MyCell(){}
@property (nonatomic, weak) IBOutlet UILabel *label;
@end


@implementation MyCell
-(void)setFolder:(NSDictionary *)folder{
    _folder = folder;
    NSString *fName = folder[@"folder_name"];
    self.label.text = fName;
}

@end
