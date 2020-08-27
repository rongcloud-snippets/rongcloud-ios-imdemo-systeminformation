//
//  RCSInformationMessage.h
//  rongcloud-ios-imdemo-systeminformation
//
//  Created by 张一帆 on 2020/8/23.
//

#import <RongIMLib/RongIMLib.h>


#define RCSInformationMessageTypeIdentifier @"RCS:InformationMsg"

NS_ASSUME_NONNULL_BEGIN

@interface RCSInformationMessage : RCMessageContent

@property (nonatomic, strong) NSString *inforTitle;

@property (nonatomic, strong) NSString *inforSubTitle;

@property (nonatomic, strong) NSString *inforUrl;


//{"inforTitle":"苹果股价还得涨","inforSubTitle":"北京时间8月25日，近日分析机构D.A. Davidson知名分析师汤姆·福尔特（Tom Forte）表示，苹果公司股价将会在今年迎来更多历史性的突破，这主要得益于5G版iPhone 12的推出以及苹果的居家办公。","inforUrl":"https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_10030678008519773834%22%7D&n_type=0&p_from=1"}

/// 初始化
/// @param inforTitle 标题
/// @param inforSubTitle 子标题
/// @param inforUrl URL
+ (instancetype)messageWithTitle:(NSString *)inforTitle inforSubTitle:(NSString *)inforSubTitle inforUrl:(NSString *)inforUrl;

@end


NS_ASSUME_NONNULL_END
