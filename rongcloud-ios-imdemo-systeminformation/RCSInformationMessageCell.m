//
//  RCSInformationMessageCell.m
//  rongcloud-ios-imdemo-systeminformation
//
//  Created by 张一帆 on 2020/8/23.
//

#import "RCSInformationMessageCell.h"
#import "RCSInformationMessage.h"
#import <MyLayout/MyLayout.h>


#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface RCSInformationMessageCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIButton *more;

@end

@implementation RCSInformationMessageCell

+ (CGSize)sizeForMessageModel:(RCMessageModel *)model withCollectionViewWidth:(CGFloat)collectionViewWidth referenceExtraHeight:(CGFloat)extraHeight {
    
    CGFloat __messagecontentview_height = 0.0f;
    
    RCSInformationMessage *infoMsg = (RCSInformationMessage *)model.content;
    
    
    float maxWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize  _textMessageSize = [RCKitUtility getTextDrawingSize:infoMsg.inforSubTitle
                                                   font:[UIFont systemFontOfSize:14]
                                        constrainedSize:CGSizeMake(maxWidth - 40, 80000)];
    _textMessageSize = CGSizeMake(ceilf(_textMessageSize.width), ceilf(_textMessageSize.height));

    CGFloat __label_height = _textMessageSize.height;
    
    CGFloat __bubbleHeight = __label_height + 8 + 8 < 40 ? 40 : (__label_height + 8 + 8);
    
    __messagecontentview_height = __bubbleHeight;

    __messagecontentview_height += extraHeight;

    __messagecontentview_height += 100 + 15;
    
    return CGSizeMake(collectionViewWidth, __messagecontentview_height);

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize {

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.titleLabel.numberOfLines = 1;
    [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.subTitleLabel = [[UILabel alloc] init];
    [self.subTitleLabel setFont:[UIFont systemFontOfSize:14]];
    self.subTitleLabel.numberOfLines = 0;
    self.more = [[UIButton alloc] initWithFrame: CGRectZero];
    [self.more.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    [self.more addTarget:self action:@selector(clickMore:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.baseContentView.backgroundColor = [UIColor colorWithRed:23 green:24 blue:31 alpha:0];
}

- (void)setDataModel:(RCMessageModel *)model {
    
    
    [super setDataModel:model];
    
    MyLinearLayout *linearLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    
    UILabel *line = [[UILabel alloc] init];
    
    
    linearLayout.myLeft = linearLayout.myRight = 15;
    
    self.titleLabel.myLeft =self.titleLabel.myRight = 5;
    self.titleLabel.myHeight = 50;
    
    self.subTitleLabel.myLeft = self.subTitleLabel.myRight = 5;
    self.subTitleLabel.myHeight = MyLayoutSize.wrap;
    self.subTitleLabel.myBottom = 15;
    line.myHeight = 1;
    line.myLeft = line.myRight = 5;

    self.more.myLeft = self.more.myRight = 5;
    self.more.myHeight = 50;
    

    [linearLayout addSubview:self.titleLabel];
    [linearLayout addSubview:self.subTitleLabel];
    [linearLayout addSubview:line];
    [linearLayout addSubview:self.more];
    [self.baseContentView addSubview:linearLayout];

    linearLayout.backgroundColor = [UIColor colorWithRed:29/255.0 green:31/255.0 blue:42/255.0 alpha:1];
    self.backgroundColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    line.backgroundColor = [UIColor whiteColor];

    RCSInformationMessage *msg = (RCSInformationMessage *)model.content;
    
    self.titleLabel.text = msg.inforTitle;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.text = msg.inforSubTitle;
    self.subTitleLabel.textColor = [UIColor whiteColor];
    [self.more setTitle:@"查看更多" forState:UIControlStateNormal];
    self.more.titleLabel.tintColor = [UIColor whiteColor];
    
}

- (void)clickMore:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
           [self.delegate didTapMessageCell:self.model];
       }
}

@end
