//
//  Channel.h
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
/**导航条*/
@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *tid;

/**加载频道数组*/
+ (NSArray *)channelList; // 类似懒加载?
@end
