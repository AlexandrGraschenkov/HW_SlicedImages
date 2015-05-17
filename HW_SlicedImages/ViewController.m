//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Alexander on 14.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "DataManager.h"
#import "MyViewController.h"

@interface ViewController ()

@end

@interface ViewController () <UITabBarDelegate, UITableViewDataSource>
{
    NSArray *dir;
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *selectedIndex = self.table.indexPathForSelectedRow;
    MyViewController *second = segue.destinationViewController;
    [second setDir:dir[selectedIndex.row]];
}

-(void)reloadIfNeeded{
    if (!dir) {
        [self.refresh beginRefreshing];
        [self reloadData];
    }
}

-(void)reloadData{
    [[DataManager sharedInstance] getNames:^(NSArray *array, NSError *error) {
        dir = array;
        [self.table reloadData];
        [self.refresh endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dir.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"CI";
    MyCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.folder = dir[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
