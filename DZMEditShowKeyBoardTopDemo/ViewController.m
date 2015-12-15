//
//  ViewController.m
//  DZMEditShowKeyBoardTopDemo
//
//  Created by haspay on 15/11/18.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"
#import "DZMEditShowKeyBoardTop.h"
@interface ViewController ()
- (IBAction)clickTbaleView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    /**
     方便键盘弹到输入框的上面 导入项目全局类  tableview  scrollview collectionView 都可以用 无论输入框在子层级有多深 都可以弹到正确位置
     注意：使用tableview的时候注意tableview 是否能自带弹动 没有才加 有就不要使用这个了
     可以下载看TestScrollViewController中使用 一看就懂 总归不超过10行代码 需要的界面输入框都能跟着键盘走 帮大家省时间
     
     DZMEditShowKeyBoardTop 使用：
     
     1.---在每一个监听对象的初始化方法里面添加 一句添加监听键盘通知的代码 该方法监听方法在。h文件顶部有帮忙写了 拷贝即可
     只有你实现的监听方法才会被添加通知 没有实现的 不会多于添加 防止了通知的多于添加
     建议在viewcontroller的viewdidiload里面添加
     
     [DZMEditShowKeyBoardTop addKeyBoardNotificationWithObject:self];
     
     2.---去DZMEditShowKeyBoardTop。h文件拷贝你需要监听键盘的监听方法到当前对象文件
     
     3.---根据对应的监听方法可以选取弹上动画 （注意： 显示效果选一种就好了 我写了两种 总之一个显示一个隐藏就行了）
     
     #pragma mark -- 键盘开始显示
     - (void)keyboardWillShowNotification:(NSNotification *)notification
     {
     [DZMEditShowKeyBoardTop keyboardWillShowNotification:notification scrollView:self.scrollview maxY:[DZMEditShowKeyBoardTop editShowKeyBoardTop].maxY];
     }
     
     #pragma mark -- 键盘开始隐藏
     - (void)keyboardWillHideNotification:(NSNotification *)notification
     {
     [DZMEditShowKeyBoardTop keyboardWillHideNotification:notification scrollView:self.scrollview];
     }
     
     4.---在每一个输入框的开始编辑代理里面添加初始化这个输入框的最大Y值方法
     
     // 只要是键盘还没有出来的方法都可以  建议这个在这个代理里面 textview 跟textfield 都有
     - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
     {
     [DZMEditShowKeyBoardTop maxYWithView:textField];
     return YES;
     }
     */
    
}

- (IBAction)clickTbaleView:(id)sender {
    TestTableViewController *tableView = [[TestTableViewController alloc] init];
    [self.navigationController pushViewController:tableView animated:YES];
}
@end
