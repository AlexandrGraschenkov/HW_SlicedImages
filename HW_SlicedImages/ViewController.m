//
//  ViewController.m
//  HW_SlicedImages
//
//  Created by Alexander on 14.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "NetManager.h"
#import "ScrollViewController.h"
#import "URLListOject.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *imgList;
    NSMutableArray *urlObjArr;
}
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.refresh = [UIRefreshControl new];
    [self.tableView addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    
    [self reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self reloadIfNescessary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Reloading methods
-(void)reloadData {
    [[NetManager sharedInstance] getImgList:^(NSArray *arr, NSError *error) {
        if (!error) {
            urlObjArr = [NSMutableArray new];
            for (NSDictionary *dict in arr)
            {
                URLListOject *tempObj = [URLListOject getURLListObjectWithName:(NSString *)dict[@"folder_name"]
                                                                  andWidth:(NSNumber *)dict[@"elem_width"]
                                                                 andHeight:(NSNumber *)dict[@"elem_height"]
                                                            andRowQuantity:(NSNumber *)dict[@"rows_count"]
                                                         andColumnQuantity:(NSNumber *)dict[@"columns_count"]];
                [urlObjArr addObject:tempObj];
            }
        } else {
            urlObjArr = nil;
            [[[UIAlertView alloc]initWithTitle:@"Downloading error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        }
        [self.tableView reloadData];
        [self.refresh endRefreshing];
    }];
}

-(void)reloadIfNescessary {
    if (!imgList) {
        [self.refresh beginRefreshing];
        [self reloadData];
    }
}

#pragma mark - TableView protocol methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return urlObjArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    URLListOject *temp = urlObjArr[indexPath.row];
    cell.textLabel.text = temp.name;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqualToString:@"ScrollViewSegue"]) {
        ScrollViewController *scrollView = [segue destinationViewController];
        scrollView.urlObject = urlObjArr[[self.tableView indexPathForSelectedRow].row];
    } else {
        NSLog(@"Uncorrect segue identifier!");
    }
}

@end
