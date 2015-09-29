//
//  NetWorkTools.m
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "NetWorkTools.h"
#import "AFNetworking.h"

@implementation NetWorkTools
+ (instancetype)shareNetWorkTools {
    static NetWorkTools * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        instance = [[self alloc] initWithBaseURL:url];
    });
    return instance;
}
@end
