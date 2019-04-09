//
//  ViewController.m
//  PerformanceAdvanture
//
//  Created by LAgagggggg on 2018/10/9.
//  Copyright © 2018 nil. All rights reserved.
//

#import "PerformanceTestViewController.h"
#import <Masonry.h>
#import "PerformanceTestTableViewCell.h"

@interface PerformanceTestViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) NSMutableArray * itemArr;

@end

@implementation PerformanceTestViewController

static NSString * const reuseIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.title=@"Performance Test";
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight=120;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerClass:[PerformanceTestTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (NSArray *)itemArr{
    if (!_itemArr) {
        _itemArr=[[NSMutableArray alloc]init];
        for (int i=0; i<100; i++) {
            PerformanceTestItem * item=[[PerformanceTestItem alloc]init];
            item.text=[NSString stringWithFormat:@"User%d",i];
            item.avatarImage=[UIImage imageNamed:@"avatar"];
            item.dataImage1=[UIImage imageNamed:@"dataImage1"];
            item.dataImage2=[UIImage imageNamed:@"dataImage2"];
            [_itemArr addObject:item];
        }
    }
    return _itemArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PerformanceTestTableViewCell * cell=[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.item=self.itemArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArr?self.itemArr.count:0;
}

@end
