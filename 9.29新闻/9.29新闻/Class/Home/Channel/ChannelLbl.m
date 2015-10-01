//
//  ChannelLbl.m
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "ChannelLbl.h"
#define SVSelFontSize 18.0
#define SVNorFontSize 14.0
@implementation ChannelLbl

+(instancetype)channelLblWithTitle:(NSString *)title {
    ChannelLbl *lbl = [[ChannelLbl alloc] init];
    lbl.text = title;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:SVSelFontSize];
    
    [lbl sizeToFit];
    lbl.font = [UIFont systemFontOfSize:SVNorFontSize];
    lbl.userInteractionEnabled = YES;
    return lbl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s",__func__); // 监听点击成功
    if ([self.delgate respondsToSelector:@selector(channelLblDelegate:)]) {
        [self.delgate channelLblDelegate:self];
    }
}

// 根据scale设置字体大小,颜色
-(void)setScale:(float)scale {
//    UIFont *font = (SVSelFontSize - SVNorFontSize) * scale;
    CGFloat percent = (SVSelFontSize - SVNorFontSize) / SVNorFontSize;
    percent = percent *scale + 1;
    self.transform = CGAffineTransformMakeScale(percent, percent); // self是textlbl
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}

//- (void)channelLblDelegate:(ChannelLbl *)lbl {
//
//} // 代理方法代理人实现就好,不方便做的事情请代理做

@end
