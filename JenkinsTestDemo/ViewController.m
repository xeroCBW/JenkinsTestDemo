//
//  ViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/20.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *listArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
        [_listArr addObject:@"LocationViewController"];
        
    }
    return _listArr;
}

@end
