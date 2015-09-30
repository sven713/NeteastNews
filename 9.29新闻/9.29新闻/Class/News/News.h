//
//  News.h
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
/**标题*/
@property (nonatomic, copy) NSString *title;
/**摘要*/
@property (nonatomic, copy) NSString *digest;
/**回帖数*/
@property (nonatomic, assign) int replyCount;
/**配图*/
@property (nonatomic, copy) NSString *imgsrc;
/**额外的两张*/
@property (nonatomic, strong) NSArray *imgextra;
/**大图*/
@property (nonatomic, assign, getter=isBigimg) BOOL imgType;

//+ (instancetype)newsWithDict:(NSDictionary *)dict;

/**懒加载*/
+ (void)loadNewsWithURL:(NSString *)urlString finish:(void(^)(NSArray *arr))finish;
// block作为参数,回调 1定义3执行写在一起(.h,.m),赋值在其他地方
@end
#warning getter是啥?