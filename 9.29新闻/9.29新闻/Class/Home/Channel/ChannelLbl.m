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
    return lbl;
}

@end
