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

@interface HomeViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *titleView;
@property (nonatomic, strong) NSArray *channelList;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

        lbl.frame = CGRectMake(x, 0, lbl.bounds.size.width, h);
        x += lbl.bounds.size.width;
        [self.titleView addSubview:lbl];
    }
#warning why? x定义在大括号外面,可以记录值
    self.titleView.contentSize = CGSizeMake(x + margin, h);
}

- (void)viewDidLayoutSubviews {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = self.collView.bounds.size.height;
    self.layout.itemSize = CGSizeMake(w, h);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.collView.pagingEnabled = YES;
    self.collView.showsHorizontalScrollIndicator = NO;
}

#pragma mark 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255) green:((float)arc4random_uniform(256) / 255) blue:((float)arc4random_uniform(256) / 255) alpha:1];
    return cell; // 没写layout
}

#pragma mark 懒加载
- (NSArray *)channelList {
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}

@end
// 目标:显示色块,两个代理方法,跟tableView很像
//