//
//  NewsTableViewController.m
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "NewsCellTableViewCell.h"

@interface NewsTableViewController ()
@property (nonatomic, strong)NSArray *newsList;
@end

@implementation NewsTableViewController

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    // @"T1348647853363/0-20.html"
    [News loadNewsWithURL:_urlString finish:^(NSArray *arr) {
        self.newsList = arr; // 需要重新set方法
    }];
}

-(void)setNewsList:(NSArray *)newsList {
    _newsList = newsList;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // url是拼接出来的
//    [News loadNewsWithURL:@"T1348647853363/0-20.html" finish:^(NSArray *arr) {
//        self.newsList = arr; // 需要重新set方法
//    }];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *newM = self.newsList[indexPath.row];
    NSString *ID = [NewsCellTableViewCell cellID:newM];
    
    NewsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
//    cell.newsM = self.newsList[indexPath.row];
    cell.newsM = newM;
    
    return cell;
}



@end
/*
 sum:1.创建联网单例 调用initWithBaseURL方法why? 后面要拼url
    2.创建News模型,工厂方法,类方法loadNewsWithURLString
    3.VC调用new类方法,验证是否从网络拉取数据成功
 目标:根据网络数据填充到cell中
     [self.tableView reloadData];不写出不来数据
 
 self.tableView.estimatedRowHeight = 100;
 self.tableView.rowHeight = UITableViewAutomaticDimension;
 自动计算行高
 */
