//
//  URLList.m
//  HW_SlicedImages
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "URLList.h"

@implementation URLList

+(instancetype)getURLListObjectWithName:(NSString *)name andWidth:(NSNumber *)width andHeight:(NSNumber *)height andRowQuantity:(NSNumber *)rowQ andColumnQuantity:(NSNumber *)colQ {
    URLList *obj = [URLList new];
    
    obj.name = name;
    obj.width = width;
    obj.height = height;
    obj.rowQuantity = rowQ;
    obj.columnQuantity = colQ;
    
    return obj;
}


@end
