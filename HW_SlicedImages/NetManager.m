//
//  NetManager.m
//  HW_SlicedImages
//
//  Created by Михаил on 14.05.15.
//  Copyright (c) 2015 Михаил. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+(id)sharedInstance{
    static NetManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
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
