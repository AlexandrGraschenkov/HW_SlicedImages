//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 ITIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+ (instancetype)sharedInstance;

- (void)getTitles:(void(^)(NSArray *, NSError *))completion;
@end
