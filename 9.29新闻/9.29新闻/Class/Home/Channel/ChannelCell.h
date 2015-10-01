//
//  ChannelCell.h
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsTableViewController;
@interface ChannelCell : UICollectionViewCell
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NewsTableViewController *vc;
@end
