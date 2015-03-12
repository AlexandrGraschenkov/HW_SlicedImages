//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "ViewController.h"
#import "NetManager.h"
#import "FolderCell.h"
#import "SecondController.h"

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
    FolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.folder = folders[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *selectedIndex = self.table.indexPathForSelectedRow;
    SecondController *second = segue.destinationViewController;
    [second setFolder:folders[selectedIndex.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
