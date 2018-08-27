//
//  HLTabuCell.h
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTabulation.h"


@interface HLTabuCell : UITableViewCell
@property (nonatomic,strong)HLTabulation *Tabu;


//在.h内声明scroll，便于控制器操作他的scrollView
@property (strong, nonatomic) UIScrollView *messageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
