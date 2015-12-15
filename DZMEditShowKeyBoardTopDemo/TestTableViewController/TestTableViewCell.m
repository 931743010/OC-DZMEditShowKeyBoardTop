//
//  TestTableViewCell.m
//  DZMEditShowKeyBoardTopDemo
//
//  Created by haspay on 15/11/18.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestView.h"
@interface TestTableViewCell()

@property (nonatomic,weak)  TestView *testView;
@end
@implementation TestTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TestTableViewCell";
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        TestView *testView = [[TestView alloc] init];
        testView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:testView];
        self.testView = testView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.testView.frame = CGRectMake(50, 0, self.frame.size.width - 50, self.frame.size.height);
}


@end
