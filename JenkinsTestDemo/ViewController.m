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
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

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
    

    NSDictionary *infoDic = NSBundle.mainBundle.infoDictionary;
    
    NSString *info = [NSString stringWithFormat:@"%@",infoDic];
    
    
    self.schemeLabel.text = [NSString stringWithFormat:@"%@",configuration];
    
    self.infoTextView.text = info;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
