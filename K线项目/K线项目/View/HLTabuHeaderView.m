//
//  HLTabuHeaderView.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLTabuHeaderView.h"

@interface HLTabuHeaderView()
//组头左侧的股票名称
@property (nonatomic,weak)UILabel *nameLabel;

@end


@implementation HLTabuHeaderView
+ (instancetype)headerWithView:(UITableView *)tableView{
    static NSString *ID = @"header";
    HLTabuHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[HLTabuHeaderView alloc]init];
    }
    return header;
}
//重写初始化方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        // 1.设置左侧股票名称frame和内部信息
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.backgroundColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.text = @"股票名称";
        nameLabel.frame = CGRectMake(0, 0, 125, 44);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.设置scroll的frame和内部信息
        UIScrollView *minute = [[UIScrollView alloc]init];
        minute.contentSize = CGSizeMake(1125, 44);
        //可视区间
        minute.frame=CGRectMake(125, 0, 250, 44);
        //取消弹簧功能
        minute.bounces = NO;
        //水平滚动条是否显示
        minute.showsHorizontalScrollIndicator = NO;
        //设置scroll的颜色
        minute.backgroundColor = [UIColor blackColor];
        
        CGFloat LabelY = 0;
        CGFloat LabelW = 125;
        CGFloat LabelH = 44;
        for (int i = 1; i<10; i++) {
            UILabel *label = [[UILabel alloc]init];
            CGFloat LabelX = (i-1)*125;
            label.frame = CGRectMake(LabelX, LabelY, LabelW, LabelH);
            //背景颜色
            label.backgroundColor = [UIColor blackColor];
            //字体颜色
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            //根据i来给每个label赋相应的值
            switch (i) {
                case 1:
                    label.text = @"最新";
                    break;
                case 2:
                    label.text = @"涨幅";
                    break;
                case 3:
                    label.text = @"涨跌";
                    break;
                case 4:
                    label.text = @"昨收";
                    break;
                case 5:
                    label.text = @"成交量";
                    break;
                case 6:
                    label.text = @"成交额";
                    break;
                case 7:
                    label.text = @"开盘价";
                    break;
                case 8:
                    label.text = @"最高价";
                    break;
                case 9:
                    label.text = @"最低价";
                    break;
                default:
                    break;
            }
            [minute addSubview:label];
        }
        //将头部视图添加到self.minute
        [self.contentView addSubview:minute];
        self.minute = minute;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.设置左侧股票名称frame和内部信息
    self.nameLabel.frame = CGRectMake(0, 0, 125, 44);
    
    // 2.设置scroll的frame和内部信息
    self.minute.contentSize = CGSizeMake(1250, 44);
    //3、可视区间
    self.minute.frame=CGRectMake(125, 0, 250, 44);
    
  
}


@end
