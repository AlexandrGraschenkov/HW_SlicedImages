//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Daniil Novoselov on 03.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+(instancetype)sharedInstance;

-(void)getImgList:(void(^)(NSArray *, NSError *))completion;


@end
