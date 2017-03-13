//
//  ViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/20.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *listArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 300;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    
}


- (void)loadMoreDate{
    
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
    [self.tableView reloadData];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        NSMutableArray  *arr = [NSMutableArray array];
//        
//        for (int i = 0; i < 20; i ++) {
//            
//            [arr addObject:[NSString stringWithFormat:@"%d",i]];
//        }
//        
//        [self.listArr addObjectsFromArray:arr.mutableCopy];
//        
//        [self.tableView reloadData];
//    });

    
}

#pragma mark - datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.listArr[indexPath.row];
    return cell;
}

#pragma mark - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //通过类来创建对象
    NSString *viewControllerString = self.listArr[indexPath.row];
    Class viewController = NSClassFromString(viewControllerString);
    
    [self.navigationController pushViewController:[[viewController alloc]init] animated:YES];
    
}

#pragma mark - lazy

-(NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        
        _listArr = [NSMutableArray array];
        [_listArr addObject:@"BaseInfoViewController"];//LocationViewController
        [_listArr addObject:@"LocationViewController"];//
        [_listArr addObject:@"MWDemoViewController"];
        
    }
    return _listArr;
}

@end
