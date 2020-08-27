//
//  RCSInformationMessage.m
//  rongcloud-ios-imdemo-systeminformation
//
//  Created by 张一帆 on 2020/8/23.
//

#import "RCSInformationMessage.h"

@implementation RCSInformationMessage


+ (instancetype)messageWithTitle:(NSString *)inforTitle inforSubTitle:(NSString *)inforSubTitle inforUrl:(NSString *)inforUrl {
    
    RCSInformationMessage *msg = [[RCSInformationMessage alloc] init];
    if (inforTitle && inforTitle && inforUrl) {
        msg.inforTitle = inforTitle;
        msg.inforSubTitle = inforSubTitle;
        msg.inforUrl = inforUrl;
    }else{
        NSLog(@"RCSInformationMessage 参数错误");
        return nil;
    }
    
    return msg;
}

+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

#pragma mark - NSCoding protocol methods
#define KEY_INFORTITLE @"inforTitle"
#define KEY_INFORSUBTITLE @"inforSubTitle"
#define KEY_INFORURL @"inforUrl"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.inforTitle = [aDecoder decodeObjectForKey:KEY_INFORTITLE];
        self.inforSubTitle = [aDecoder decodeObjectForKey:KEY_INFORSUBTITLE];
        self.inforUrl = [aDecoder decodeObjectForKey:KEY_INFORURL];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.inforTitle forKey:KEY_INFORTITLE];
    [aCoder encodeObject:self.inforSubTitle forKey:KEY_INFORSUBTITLE];
    [aCoder encodeObject:self.inforUrl forKey:KEY_INFORURL];
}

#pragma mark - RCMessageCoding delegate methods

- (NSData *)encode {

    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];

    if (self.inforTitle) {
        [dataDict setObject:@(self.destructDuration) forKey:KEY_INFORTITLE];
    }
    if (self.inforSubTitle) {
        [dataDict setObject:self.inforSubTitle forKey:KEY_INFORSUBTITLE];
    }
    
    if (self.inforUrl) {
        [dataDict setObject:self.inforUrl forKey:@"inforUrl"];
    }
    if (self.senderUserInfo) {
        [dataDict setObject:[self encodeUserInfo:self.senderUserInfo] forKey:@"user"];
    }
    if (self.mentionedInfo) {
        [dataDict setObject:[self encodeMentionedInfo:self.mentionedInfo] forKey:@"mentionedInfo"];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
    return data;
}

- (void)decodeWithData:(NSData *)data {
    __autoreleasing NSError *__error = nil;
    if (!data) {
        return;
    }
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&__error];

    if (dictionary) {
        self.inforTitle = [dictionary objectForKey:KEY_INFORTITLE];
        self.inforSubTitle = [dictionary objectForKey:KEY_INFORSUBTITLE];
        self.inforUrl = [dictionary objectForKey:KEY_INFORURL];

        NSDictionary *mentionedInfoDic = [dictionary objectForKey:@"mentionedInfo"];
        [self decodeMentionedInfo:mentionedInfoDic];

        NSDictionary *userinfoDic = [dictionary objectForKey:@"user"];
        [self decodeUserInfo:userinfoDic];
    }
}

+ (NSString *)getObjectName {
    return RCSInformationMessageTypeIdentifier;
}


- (NSString *)conversationDigest {
    NSString *conversationDigest = self.inforTitle;
    return conversationDigest;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif //__has_feature(objc_arc)
@end
