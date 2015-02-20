//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Gena on 18.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+ (instancetype)sharedInstance;

- (void)getTitles:(void(^)(NSArray *, NSError *))completion;

@end
