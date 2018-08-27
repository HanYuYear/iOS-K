//
//  ViewController.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/22.
//  Copyright © 2018年 com.homily. All rights reserved.
//K线项目的行情页面，可以完成头部视图的联合滚动


#import "HLTabuViewController.h"
#import "HLTabulation.h"
#import "HLTabuCell.h"
#import "HLTabuHeaderView.h"
#import "HLDetailsViewController.h"
@interface HLTabuViewController ()<NSXMLParserDelegate>
//创建一个数组，用来动态拼接XML数据
@property (nonatomic,strong)NSMutableArray *tabuList;
//不可变得数组，用来记录表格
@property (nonatomic,strong)NSArray *tabuLists;
//创建一个可变字符串，用来拼接xml文件中的数据
@property (nonatomic,strong)NSMutableString *tabuStr;
//创建一个列表模型
@property (nonatomic,strong)HLTabulation *h;
//创建一个UITableView视图
@property (strong, nonatomic) IBOutlet UITableView *tabuTableView;
//创建一个可变数组，用来记录scroll联动滚动的值
@property (nonatomic,strong)NSMutableArray *scArray;
//创建一个控制器，声明将要跳转的控制器
@property (nonatomic,strong)HLDetailsViewController *mainDetails;
@end

@implementation HLTabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据，解析数据
    [self loadData];
    //去掉cell内部的分割线
    self.tabuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //创建一个监听事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //注册一个监听事件
    [center addObserver:self selector:@selector(move:) name:@"moveTZ" object:nil];
    
}
//懒加载一个数组，用来盛放移动cell的UIscrollView
-(NSMutableArray *)scArray{
    
    if(_scArray==nil){
        
        _scArray=[NSMutableArray array];
    }
    return _scArray;
}
//设置通知，当滚动的时候会把移动值传过来
- (void)move:(NSNotification *)note{
 

    for (UIScrollView *scroll in self.scArray) {
        
        NSDictionary *dict=note.userInfo;
        NSString *moveX = dict[@"moveX"];
        scroll.contentOffset=CGPointMake([moveX floatValue], 0);
    }
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 表格的数据源方法
//一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.tabuLists.count;
}

/**
 给每一行创建一个cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1创建cell
    HLTabuCell *cell = [HLTabuCell cellWithTableView:tableView];
    //判断并设置数据
    if(self.tabuLists.count>indexPath.row){
        
        
        cell.Tabu = self.tabuLists[indexPath.row];
    }
    //将每一个cell的scrollView传进一个数组内，方便更改
    [self.scArray addObject:cell.messageView];
    
    return cell;
}


/**
设置组头视图
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //创建一个组头视图
    HLTabuHeaderView *header = [HLTabuHeaderView headerWithView:tableView];
    //将组头的messageView也传进数组，方便更改
    [self.scArray addObject:header.minute];
    return header;
}

/**
设置组头的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}





#pragma mark -代理方法

/**
 点击每一个cell的时候，触发方法
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%d个cell",(int)indexPath.row);
    HLDetailsViewController *mainDetail = [[HLDetailsViewController alloc]init];
    //隐藏下面的工具栏
    mainDetail.hidesBottomBarWhenPushed = YES;
    //跳转到这个控制器
    [self.navigationController pushViewController:mainDetail animated:NO];
    
}





#pragma mark - 加载数据，解析数据
- (void)loadData{
    //URL
    NSURL *url = [NSURL URLWithString:@"file:///Users/homilyiosfivemac-mini/Desktop/IOS%E5%85%A5%E8%81%8C%E6%B5%8B%E8%AF%95%E9%A2%98-%E4%B8%AD%E7%BA%A7/List.xml"];
    //request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
    //发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *data = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //1、
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        //2、设置代理
        parser.delegate = self;
        //3、开始解析
        [parser parse];
    }];
    [data resume];
    
}




#pragma mark - xml解析代理方法
//1开始
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    //    NSLog(@"开始解析文档");
    //1、懒加载数组
    if (!self.tabuList) {
        self.tabuList = [NSMutableArray array];
    }else{
        [self.tabuList removeAllObjects];
    }
    //初始化字符串elementString
    if (!self.tabuStr) {
        self.tabuStr = [NSMutableString string];
    }else{
        [self.tabuStr setString:@""];
    }
    
}

//2开始一个节点 <element> 是一个节点名称
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    //    NSLog(@"开始节点%@  %@",elementName,attributeDict);
    if ([elementName isEqualToString:@"data"]) {
        
        self.h = [[HLTabulation alloc]init];
    }
    //每一个新节点之前都清空elementString
    //避免每一次的结果被重复拼接
    self.tabuStr = [NSMutableString string];
}

//3查找内容,可能会重复多次
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //拼接
    [self.tabuStr appendString:string];
    
}

//4节点结束 </element>
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"data"]) {
        [self.tabuList addObject:self.h];
    }else if (![elementName isEqualToString:@"datas"]){//表示最后一个节点
        [self.h setValue:self.tabuStr forKey:elementName];
    }
  
}

//5文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
        //在iOS开发中用一个可变对象给一个不可变对象赋值时，使用copy是一个hao'xi'gua
 
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.tabuLists = [self.tabuList copy];
        
        [self.tabuTableView reloadData];
    });
}
//出错处理
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"出错啦@");
 
}






@end
