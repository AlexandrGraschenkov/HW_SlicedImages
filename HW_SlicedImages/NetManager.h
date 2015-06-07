//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by itisioslab on 18.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetManager : UITableViewCell
+(instancetype)sharedInstance;
-(void)getTtiles:(void(^)(NSArray *, NSError *))completion;
@end
