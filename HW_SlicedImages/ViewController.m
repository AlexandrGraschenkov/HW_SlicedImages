//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Михаил on 14.05.15.
//  Copyright (c) 2015 Михаил. All rights reserved.
//

#import "ViewController.h"
#import "NetManager.h"
#import "Cell.h"
#import "ImageViewController.h"

@interface ViewController () <UITabBarDelegate, UITableViewDataSource>
{
    NSArray *folders;
}
@property (nonatomic,strong) UIRefreshControl *refresh;
@property (nonatomic,weak) IBOutlet UITableView *table;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.refresh = [UIRefreshControl new];
    [self.table addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadIfNeeded];
}

-(void)reloadIfNeeded{
    if (!folders) {
        [self.refresh beginRefreshing];
        [self reloadData];
    }
}

-(void)reloadData{
    [[NetManager sharedInstance] getNames:^(NSArray *arr, NSError *err) {
        folders = arr;
        [self.table reloadData];
        [self.refresh endRefreshing];
    }];
}

#pragma mark - TableMethods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return folders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    Cell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.folder = folders[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *selectedIndex = self.table.indexPathForSelectedRow;
    ImageViewController *iv = segue.destinationViewController;
    [iv setFolder:folders[selectedIndex.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
