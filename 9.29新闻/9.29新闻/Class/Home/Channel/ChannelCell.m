//
//  ChannelCell.m
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "ChannelCell.h"
#import "NewsTableViewController.h"

@interface ChannelCell ()
@property (nonatomic, strong) NewsTableViewController *vc;
@end

@implementation ChannelCell
// 从xib/sb一加载就执行
-(void)awakeFromNib {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]];
    self.vc = sb.instantiateInitialViewController;
    [self addSubview:self.vc.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.vc.view.frame = self.bounds;
}

@end
// 目标:让cell显示网页数据
// 