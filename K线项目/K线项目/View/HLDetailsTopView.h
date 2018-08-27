//
//  HLDetailsTopView.h
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/27.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLDetails;
@protocol HLDetailsTopViewDelegate <NSObject>
@optional
- (void)HLDetailsTopViewReload;
@end


@interface HLDetailsTopView : UIView

//上方数组模型
@property (nonatomic,strong)HLDetails *t;
@property (nonatomic,weak)id<HLDetailsTopViewDelegate> delegate;
@end
