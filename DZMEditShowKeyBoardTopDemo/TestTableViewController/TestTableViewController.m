//
//  TestTableViewController.m
//  DZMEditShowKeyBoardTopDemo
//
//  Created by haspay on 15/11/18.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import "DZMEditShowKeyBoardTop.h"
@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [DZMEditShowKeyBoardTop addKeyBoardNotificationWithObject:self];
    
}

#pragma mark -- 键盘结束显示
- (void)keyboardDidShowNotification:(NSNotification *)notification
{
    [DZMEditShowKeyBoardTop keyboardShowNotification:notification scrollView:self.tableView maxY:[DZMEditShowKeyBoardTop editShowKeyBoardTop].maxY];
}

#pragma mark -- 键盘开始隐藏
- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    [DZMEditShowKeyBoardTop keyboardHideNotification:notification];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TestTableViewCell *cell = [TestTableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
