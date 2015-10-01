//
//  ChannelLbl.h
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChannelLblDelegate;


@interface ChannelLbl : UILabel
+ (instancetype)channelLblWithTitle:(NSString *)title;
/**字体缩放比例0-1*/
@property (nonatomic, assign) float scale;
@property (nonatomic, weak) id<ChannelLblDelegate>delgate;
@end

@protocol ChannelLblDelegate <NSObject>

// 点击lbl切换
- (void)channelLblDelegate:(ChannelLbl *)lbl;

@end