//
//  HomeViewController.m
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
#import "ChannelLbl.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleView;
@property (nonatomic, strong) NSArray *channelList;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",[Channel channelList]);
    [self setUpChannel];
}

- (void)setUpChannel {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.titleView.bounds.size.height;
    
    // 遍历频道数组,添加label
    for (Channel *chan in self.channelList) {
        
        ChannelLbl *lbl = [ChannelLbl channelLblWithTitle:chan.tname];
        /*
//        UILabel *lbl = [[UILabel alloc] init];
//        lbl.text = chan.tname;
//        [lbl sizeToFit];*/
        lbl.frame = CGRectMake(x, 0, lbl.bounds.size.width, h);
        x += lbl.bounds.size.width;
        [self.titleView addSubview:lbl];
    }
#warning why?
    self.titleView.contentSize = CGSizeMake(x + margin, h);
    
}

#pragma mark 懒加载
- (NSArray *)channelList {
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}

@end
// 目标:显示色块