//
//  NetManager.m
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+(instancetype)sharedInstance{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

-(void)getNames:(void(^)(NSArray *, NSError *))completeion{
    NSURL *jsonUrl = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSURLSessionDataTask *myTask = [[NSURLSession sharedSession] dataTaskWithURL:jsonUrl completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error){
         if (!error) {
             NSArray *parsedFolders = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             if (!error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     completeion(parsedFolders, nil);
                 });
                 return;
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completeion(nil, error);
         });
     }];
    [myTask resume];
}
@end
