//
//  HLTabuCell.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLTabuCell.h"
//添加一个手势点击事件
@interface HLTabuCell()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) UILabel *nameLable;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong)NSMutableArray *messages;
@property (nonatomic,assign)float setX;
@property (nonatomic,strong)NSMutableArray *lableArray;
@end



@implementation HLTabuCell

-(UIScrollView *)messageView{

    if(_messageView==nil){

        _messageView=[[UIScrollView alloc]init];
    }
    return _messageView;
}

-(NSMutableArray *)lableArray{
    
    if(_lableArray==nil){
        
        _lableArray=[NSMutableArray array];
    }
    return _lableArray;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    //1创建cell
    static NSString *ID = @"CELL";
    HLTabuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2设置cell的数据
    if (cell == nil) {
        cell  = [[HLTabuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        //设置cell的背景颜色和点击无变化的事件
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    

    return cell;
}

- (void)setTabu:(HLTabulation *)Tabu{
    _Tabu = Tabu;
    //1、股票名称
    self.textLabel.text = [NSString stringWithFormat:@"%@",Tabu.name];
    
    //2、副标题名称
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@",Tabu.code];
    
    //3、设置scroll里面的label属性
    //取消弹簧功能
    self.messageView.bounces = NO;
    //隐藏水平滚动条
    self.messageView.showsHorizontalScrollIndicator = NO;
    CGFloat LabelY = 0;
    CGFloat LabelW = 125;
    CGFloat LabelH = 44;
    //创建11个新的label
    //
    if(self.lableArray.count<10){
        for (int i = 1; i<11; i++) {
            UILabel *label = [[UILabel alloc]init];
            
            [self.lableArray addObject:label];
            
            CGFloat LabelX = (i-1)*125;
            label.frame = CGRectMake(LabelX, LabelY, LabelW, LabelH);
            label.backgroundColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            //根据i来给每个label赋相应的值
            switch (i) {
                case 1:
                    label.text = Tabu.price;
                    break;
                case 2:
                    label.text = Tabu.rate;
                    break;
                case 3:
                    label.text = Tabu.rise;
                    break;
                case 4:
                    label.text = Tabu.preClose;
                    break;
                case 5:
                    label.text = Tabu.vol;
                    break;
                case 6:
                    label.text = Tabu.amount;
                    break;
                case 7:
                    label.text = Tabu.open;
                    break;
                case 8:
                    label.text = Tabu.high;
                    break;
                case 9:
                    label.text = Tabu.low;
                    break;
                default:
                    break;
            }
            [self.messageView addSubview:label];
            //给每一个scrollView添加代理
            self.messageView.delegate = self;
            
        }
        
    }
    [self.contentView addSubview:self.messageView];
    
    //关闭scrollView的交互功能
    self.messageView.userInteractionEnabled=NO;
    //打开scrollView的滑动手势，自带的滑动手势
    [self addGestureRecognizer:self.messageView.panGestureRecognizer];
 
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //1、设置股票名称字体颜色
    self.textLabel.backgroundColor = [UIColor blackColor];
    self.textLabel.textColor = [UIColor yellowColor];
    self.textLabel.font = [UIFont systemFontOfSize:11];
    
    //2设置名称下方的标号
    self.detailTextLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    
    //3、设置scrollView的frame
    self.messageView.contentSize = CGSizeMake(1125, 44);
    //可视区间
    self.messageView.frame=CGRectMake(125, 0, 250, 44);
    //4、将保存好的偏移量，复制后新创建出来的每一个cell
    self.messageView.contentOffset = CGPointMake(self.setX, 0);
}


#pragma mark - 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //创建一个通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //发送通知
    NSString *num = [NSString stringWithFormat:@"%f",scrollView.contentOffset.x] ;
    //用来保存这个便宜量
    self.setX = scrollView.contentOffset.x;
    NSDictionary *dict=@{@"moveX":num};
    [center postNotificationName:@"moveTZ" object:nil userInfo:dict];
}




@end
