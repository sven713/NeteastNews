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
#import "ChannelCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UIScrollViewDelegate,ChannelLblDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleView;
@property (nonatomic, strong) NSArray *channelList;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation HomeViewController
/*// 结束滚动才调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__); // 不能时时监控
} */
#pragma mark lbl代理方法
-(void)channelLblDelegate:(ChannelLbl *)lbl {
    NSLog(@"%@,%tu",lbl.text,lbl.tag); // 点击获取了标签文字
    // 目标:切换视图 tag
    self.currentIndex = lbl.tag;
    // 将tag转换成path          NSIndexPath indexPathWithIndex:self.currentIndex 会崩溃
    // [NSIndexPath indexPathForItem:self.currentIndex inSection:0]
    NSIndexPath *path = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    // collectionView滚动到指定的indexPath
    [self.collView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    // UICollectionViewScrollPositionCenteredHorizontally其他参数不行
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 在哪里加tag
    ChannelLbl *lbl = self.titleView.subviews[self.currentIndex];
//    NSLog(@"当前%@",lbl.text) ;
    // 下一个标签,可见
    NSArray *arr = [self.collView indexPathsForVisibleItems];
//    NSLog(@"%@",arr); // arr里面是NSIndexPath
    ChannelLbl *nextLbl = nil;
    for (NSIndexPath *idx in arr) {
        if (idx.item != self.currentIndex) { // item是collection的row
            nextLbl = self.titleView.subviews[idx.item];
            break;
        }
    }
    
    NSLog(@"idx%tu,current%@ nextlbl%@",self.currentIndex,lbl.text,nextLbl.text);
    // 计算缩放比例,根据比例调整字号大小
    self.scale = ABS((float)scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width - self.currentIndex);
    NSLog(@"scale%.2f",self.scale);
    lbl.scale = 1 - self.scale;
    nextLbl.scale = self.scale;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width ;
    NSLog(@"%tu",self.currentIndex);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChannel];
}

- (void)setUpChannel {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.titleView.bounds.size.height;
    NSInteger index = 0;
    // 遍历频道数组,添加label
    for (Channel *chan in self.channelList) {
        
        ChannelLbl *lbl = [ChannelLbl channelLblWithTitle:chan.tname];

        lbl.frame = CGRectMake(x, 0, lbl.bounds.size.width, h);
        x += lbl.bounds.size.width;
        [self.titleView addSubview:lbl];
        lbl.delgate = self;
        lbl.tag = index ++; // 在forin循环外面设置值就能记录循环的索引了
    }
    self.titleView.contentSize = CGSizeMake(x + margin, h);
    
    // 当前选中第0项
    self.currentIndex = 0;
    ChannelLbl *firstLbl = self.titleView.subviews[0];
    firstLbl.scale = 1;
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
    
    self.collView.delegate = (id)self;
}

#pragma mark 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255) green:((float)arc4random_uniform(256) / 255) blue:((float)arc4random_uniform(256) / 255) alpha:1];

//    Channel *model = self.channelList[indexPath.item];
//    cell.urlStr = model.tid;
    cell.urlString = [self.channelList[indexPath.item] urlString];
//    NSLog(@"%@",cell.urlString);
    
    // 多vc,要添加子控制器,否则响应者链条可能有问题
    if (![self.childViewControllers containsObject:cell.vc]) {
        [self addChildViewController:(UIViewController *)cell.vc];
    }
    NSLog(@"%@",self.childViewControllers);
    
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
// 目标:导航条跟新闻联动,思路:根据contentoffset计算当前是第几个页面
// 通过tag值