//
//  TableViewController.m
//  HW_SlicedImages
//
//  Created by Gena on 18.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "TableViewController.h"
#import "NetManager.h"
#import "DetailViewController.h"

@interface TableViewController () {
    NSArray *myData;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    [[NetManager sharedInstance] getTitles:^(NSArray *arr, NSError *error) {
        myData = arr;
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = myData[indexPath.row][@"folder_name"];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    DetailViewController *detail = segue.destinationViewController;
    [detail setDict:myData[indexPath.row]];
}


@end
