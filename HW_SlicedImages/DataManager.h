//
//  DataManager.h
//  HW_SlicedImages
//
//  Created by Admin on 16.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+(instancetype)sharedInstance;
-(void)getNames:(void(^)(NSArray *, NSError *))completeion;

@end
