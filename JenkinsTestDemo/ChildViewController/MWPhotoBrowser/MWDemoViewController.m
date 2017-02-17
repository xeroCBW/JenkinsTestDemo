//
//  MWDemoViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 17/2/17.
//  Copyright © 2017年 陈博文. All rights reserved.
//

#import "MWDemoViewController.h"
#import <MWPhotoBrowser.h>

@interface MWDemoViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray  *photos;

@property (nonatomic, strong) NSMutableArray  *imageNames;
@end

@implementation MWDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addImages];
    //    [self createPhotos];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self photos];
    [self createBrowser];
}


- (void)createBrowser{
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Customise selection images to change colours if required
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:1];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


- (void)addImages{
    self.imageNames = [NSMutableArray array];
    
    for (int i=1; i<=8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"photo%d",i];
        [self.imageNames addObject:imageName];
    }
}


- (void)createPhotos{
    self.photos = [NSMutableArray array];
    for (int i=0; i<self.imageNames.count; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.imageNames[i] ofType:@"jpg"];
        NSURL   *url = [NSURL fileURLWithPath:path];
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        [self.photos addObject:photo];
    }
    
}

#pragma mark - lazy

-(NSMutableArray *)photos{
    
    if (_photos) {
        _photos = [NSMutableArray array];
//        [_photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2l" ofType:@"jpg"]]]];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3051434644,3251894413&fm=23&gp=0.jpg"]]];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]]];
        
        MWPhoto *video = [MWPhoto photoWithURL:[NSURL URLWithString:@"https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-15/e15/11192696_824079697688618_1761661_n.jpg"]];
        video.videoURL = [[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xpa1/t50.2886-16/11200303_1440130956287424_1714699187_n.mp4"];
        [_photos addObject:video];
    }
    return _photos;
}

@end
