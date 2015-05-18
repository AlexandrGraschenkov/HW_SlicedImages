//
//  ViewController.h
//  HW_SlicedImages
//
//  Created by Alexander on 14.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>


@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

