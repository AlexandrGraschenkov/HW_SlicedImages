//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Евгений Сергеев on 16.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+ (instancetype)sharedInstance;

- (void)getTitles:(void(^)(NSArray *, NSError *))completion;

@end
