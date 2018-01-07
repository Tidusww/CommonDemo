//
//  RootTableViewController.m
//  TidusWWDemo
//
//  Created by Tidus on 16/3/11.
//  Copyright © 2016年 Tidus. All rights reserved.
//

#import <objc/runtime.h>
#import "RootTableViewController.h"
#import "WWFoldable.h"


static NSString *const kTableViewCellReuseID = @"kTableViewCellReuseID";
static NSString *const kTableViewHeaderReuseID = @"kTableViewHeaderReuseID";

@interface RootTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation RootTableViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - layout
- (void)viewDidLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
}

#pragma mark - getter
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kTableViewHeaderReuseID];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseID];
        
        //设置可折叠
        _tableView.ww_foldable = YES;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataList
{
    if(!_dataList){
        //加载菜单
        NSString *menuPath = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"plist"];
        NSArray *menu = [[NSArray alloc] initWithContentsOfFile:menuPath];
        _dataList = menu.mutableCopy;
    }
    return _dataList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionList = [self.dataList[section] objectForKey:@"list"];
    if(!sectionList || [tableView ww_isSectionFolded:section]){
        return 0;
    }
    return sectionList.count;
    
}

#pragma mark - UITableViewDelegate
#pragma mark header/footer
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = nil;
    
    header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableViewHeaderReuseID ];
    if(!header){
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kTableViewHeaderReuseID];
    }
    
    
    if(header){
        NSString *title = [self.dataList[section] objectForKey:@"title"];
        header.textLabel.text = title.length==0 ? [NSString stringWithFormat:@"第%@组", @(section+1)] : title;
        header.tag = section;
        
        //点击手势
        if(header.gestureRecognizers.count == 0){
            UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapped:)];
            [header addGestureRecognizer:tapgr];
        }
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseID forIndexPath:indexPath];
    
    NSDictionary *rowData = [self rowDataForIndexPath:indexPath];
    
    NSString *rowName = rowData[@"title"];
    cell.textLabel.text = rowName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *rowData = [self rowDataForIndexPath:indexPath];
    NSString *url = rowData[@"url"];
    [WWRouter routeToUrl:url param:nil];
   
}

#pragma mark - 数据源
- (NSDictionary *)rowDataForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *sectionList = [self.dataList[section] objectForKey:@"list"];
    NSDictionary *rowData = sectionList[row];
    return rowData;
}

#pragma mark - gesture
- (void)gestureTapped:(UIGestureRecognizer *)gesture
{
    UIView *header = gesture.view;
    NSInteger section = header.tag;
    [self.tableView ww_foldSection:section fold:![self.tableView ww_isSectionFolded:section]];
    
}

@end
