//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Alexander on 14.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//
#import "NetManager.h"
#import "ViewController.h"
#import "TableCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MyViewController.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *imgsArray;
}
@property (nonatomic, weak) IBOutlet UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
    
}

-(void)reloadData
{
    [[NetManager sharedInstance]
     getTtiles:^(NSArray *arr, NSError *error){
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    // cell.imgs = imgsArray[indexPath.row];
    
    cell.textLabel.text = imgsArray[indexPath.row][@"folder_name"];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = self.table.indexPathForSelectedRow;
    MyViewController *control = segue.destinationViewController;
    [control setDict:imgsArray[indexPath.row]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
