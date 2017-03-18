//
//  QLMMineUserInfoDetailController.m
//  Qomolangma
//
//  Created by Aioria on 2017/3/18.
//  Copyright © 2017年 Focus. All rights reserved.
//

#import "QLMMineUserInfoDetailController.h"
#import "QLMMineUserInfoTopCell.h"
#import "QLMMineUserInfoBottomCell.h"

@interface QLMMineUserInfoDetailController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray<NSArray *> *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@end

static NSString * const reuseID = @"reuseID";

static NSString * const topReuseID = @"topReuseID";

@implementation QLMMineUserInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = @[@[@{@"name":@"昵称:",@"detail":@"点击设置"},@{@"name":@"性别:",@"detail":@"点击设置"},@{@"name":@"出生年份:",@"detail":@"点击设置"}],
                       @[@{@"name":@"学历:",@"detail":@"点击设置"},@{@"name":@"行业:",@"detail":@"点击设置"},@{@"name":@"职业:",@"detail":@"点击设置"}]];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"编辑资料";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.separatorColor = [UIColor colorWithWhite:.8 alpha:.8];
    
    [self.view addSubview: tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.bottom.right.offset(0);
    }];
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, .1)];
    
    [tableView registerClass:[QLMMineUserInfoTopCell class] forCellReuseIdentifier:topReuseID];
    [tableView registerClass:[QLMMineUserInfoBottomCell class] forCellReuseIdentifier:reuseID];
    
    self.tableView = tableView;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return self.dataArray[section - 1].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        QLMMineUserInfoTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topReuseID forIndexPath:indexPath];
        
        return cell;
    }
    
    else
    {
        QLMMineUserInfoBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
        
        NSDictionary *dict = self.dataArray[indexPath.section - 1][indexPath.row];
        
        cell.dicDescription = dict;
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 150;
    }
    return 55;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0)
    {

    }
}


- (void)keyboardWillHide: (NSNotification *)sender
{
    CGRect rect = [sender.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -rect.size.height, 0);
    CGPoint offset =  self.tableView.contentOffset;
    self.tableView.contentOffset = CGPointMake(0, offset.y - rect.size.height);

    
    [UIView animateWithDuration:.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow: (NSNotification *)sender
{
    CGRect rect = [sender.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0);
    CGPoint offset =  self.tableView.contentOffset;
    
    self.tableView.contentOffset = CGPointMake(0, offset.y + rect.size.height);
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end