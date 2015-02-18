//
//  NetManager.m
//  HW_SlicedImages
//
//  Created by Gena on 18.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

+ (instancetype)sharedInstance
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)getTitles:(void(^)(NSArray *, NSError *))completion
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSArray *objects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!error) {
                completion(objects, nil);
                return;
            }
        }
        completion(nil, error);
    }];
}

@end
