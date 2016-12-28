//
//  ViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/20.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *schemeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *configuration = nil;
    
    
#ifdef DEBUG
    
    configuration = @"DEBUG";
    
#else
    
    configuration = @"RELEASE";
    
#endif
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    
    
    self.schemeLabel.text = [NSString stringWithFormat:@"%@-%@",prodName ,configuration];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
