//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+(instancetype)sharedInstance;
-(void)getNames:(void(^)(NSArray *, NSError *))completeion;
@end
