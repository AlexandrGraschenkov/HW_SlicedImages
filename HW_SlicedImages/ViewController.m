//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Alexander on 14.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "TableCell.h"
#import "NetManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *imgsArray;
}
@property (nonatomic, weak) IBOutlet UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
}

-(void)reloadData
{
    [[NetManager sharedInstance]
     getListImages:^(NSArray *arr, NSError *error){
         imgsArray = arr;
         [self.table reloadData];
     }];
}
#pragma mark - Table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"Cell";
    TableCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.imgs = imgsArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
