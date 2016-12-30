//
//  BaseInfoViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/30.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "BaseInfoViewController.h"

@interface BaseInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *schemeLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
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



@end
