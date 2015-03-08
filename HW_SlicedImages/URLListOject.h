//
//  URLListOject.h
//  HW_SlicedImages
//
//  Created by Daniil Novoselov on 03.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLListOject : NSObject
@property NSString *name;
@property NSNumber *width;
@property NSNumber *height;
@property NSNumber *rowQuantity;
@property NSNumber *columnQuantity;


+(instancetype)getURLListObjectWithName:(NSString *)name andWidth:(NSNumber *)width andHeight:(NSNumber *)height andRowQuantity:(NSNumber *)rowQ andColumnQuantity:(NSNumber *)colQ;

@end
