//
//  RCSConversationViewController.m
//  RCSuppportDemo
//
//  Created by 张一帆 on 2020/6/15.
//  Copyright © 2020 RCSupport. All rights reserved.
//

#import "RCSConversationViewController.h"
#import "RCSInformationMessageCell.h"
#import "RCSInformationMessage.h"


@interface RCSConversationViewController ()

@end

@implementation RCSConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.conversationMessageCollectionView.backgroundColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];

    [self registerClass:[RCSInformationMessageCell class] forMessageClass:[RCSInformationMessage class]];
    
    if (self.conversationType == ConversationType_SYSTEM) {
        [self.chatSessionInputBarControl removeFromSuperview];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.conversationMessageCollectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}


- (void)didTapMessageCell:(RCMessageModel *)model {
    
    [super didTapMessageCell:model];
    
    if (model.conversationType == ConversationType_SYSTEM && [model.content isKindOfClass:[RCSInformationMessage class]]) {
        
        // 处理点击事件
        RCSInformationMessage *msg = (RCSInformationMessage *)model.content;
        NSLog(@"url %@",msg.inforUrl);
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
