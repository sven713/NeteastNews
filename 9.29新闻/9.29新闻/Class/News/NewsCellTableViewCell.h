//
//  NewsCellTableViewCell.h
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@interface NewsCellTableViewCell : UITableViewCell
@property (nonatomic, strong) News *newsM;

+ (NSString *)cellID:(News *)news;
@end
