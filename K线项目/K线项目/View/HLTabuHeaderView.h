//
//  HLTabuHeaderView.h
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTabuHeaderView : UITableViewHeaderFooterView
+ (instancetype)headerWithView:(UITableView *)tableView;

//组头的详细信息
@property (nonatomic,weak)UIScrollView *minute;
@end
