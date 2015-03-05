//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 ITIS. All rights reserved.
//

#import "ViewController.h"
#import "NetManager.h"
#import "ImageViewContr.h"

@interface ViewController ()
{
    NSArray *data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
}

- (void)loadData
{
    [[NetManager sharedInstance] getTitles:^(NSArray *arr, NSError *error) {
        data = arr;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row][@"folder_name"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    ImageViewContr *img = segue.destinationViewController;
    [img setDict: data[indexPath.row]];
}


@end
