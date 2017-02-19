//
//  MWDemoViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 17/2/17.
//  Copyright © 2017年 陈博文. All rights reserved.
//

#import "MWDemoViewController.h"
#import "Menu.h"

@interface MWDemoViewController ()

@end

@implementation MWDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];

}


- (void)setUpNavigationBar{
    
    //设置右边的NavigationButton
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"图片浏览器" style:0 target:self action:@selector(openPhotoVC)];
    self.navigationItem.rightBarButtonItem = right;
    
}


- (void)openPhotoVC{
    
    Menu *vc = [[Menu alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
