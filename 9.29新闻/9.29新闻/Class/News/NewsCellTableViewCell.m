//
//  NewsCellTableViewCell.m
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "NewsCellTableViewCell.h"
#import "News.h"
#import "UIImageView+AFNetworking.h"

@interface NewsCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *talkLbl;
//@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImgViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImgViews;

@end

@implementation NewsCellTableViewCell

-(void)setNewsM:(News *)newsM {
    _newsM = newsM;
    self.titleLbl.text = newsM.title;
    self.detailLbl.text = newsM.digest;
    self.talkLbl.text = [NSString stringWithFormat:@"%d跟帖",newsM.replyCount];
/*
    NSURL *url = [NSURL URLWithString:newsM.imgsrc];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imageView.image = [UIImage imageWithData:data];*/
    [self.imgView setImageWithURL:[NSURL URLWithString:newsM.imgsrc]];
    
    if (newsM.imgextra.count == 2) { // 两张图
        int index = 0;
        for (UIImageView *iv in self.extraImgViews) {
            NSLog(@"%d",index);
            NSString *urlString = newsM.imgextra[index][@"imgsrc"];
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            iv.image = [UIImage imageWithData:data];
            index ++;
        }
    }
    
}

+(NSString *)cellID:(News *)news {
    if (news.imgextra.count == 2) {
        NSLog(@"sssss");
        return @"BigImg";
    }
    if (news.imgType) {
        return @"RBig";
    }
    return @"News";
}

- (void)awakeFromNib {
#warning ???宽度-116 imageView
    self.detailLbl.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.imgView.frame) - 16;
    self.titleLbl.numberOfLines = 0;
//    self.titleLbl.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.imgView.frame) - 16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
// 添加模型属性,给控件赋值
// 刚才崩溃了是因为连线有问题,一个imgView连了好几条线,提示数组越界
