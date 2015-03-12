//
//  URLListOject.m
//  HW_SlicedImages
//
//  Created by Daniil Novoselov on 03.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "URLListOject.h"
@interface URLListOject()


@end

@implementation URLListOject


+(instancetype)getURLListObjectWithName:(NSString *)name andWidth:(NSNumber *)width andHeight:(NSNumber *)height andRowQuantity:(NSNumber *)rowQ andColumnQuantity:(NSNumber *)colQ {
    URLListOject *obj = [URLListOject new];
    
    obj.name = name;
    obj.width = width;
    obj.height = height;
    obj.rowQuantity = rowQ;
    obj.columnQuantity = colQ;
    
    return obj;
}
@end
