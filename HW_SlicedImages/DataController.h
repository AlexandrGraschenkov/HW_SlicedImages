//
//  DataController.h
//  HW_SlicedImages
//
//  Created by itisioslab on 17.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataController : UITableViewCell

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imageName;

+(NSArray *)fetchData;

@end
