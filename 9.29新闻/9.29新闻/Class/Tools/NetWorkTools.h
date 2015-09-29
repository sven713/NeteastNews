//
//  NetWorkTools.h
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetWorkTools : AFHTTPSessionManager
+ (instancetype)shareNetWorkTools;
@end

// 继承错了 AFHTTPSessionManager.h