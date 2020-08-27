//
//  LGAFNetWorkManager.h
//  LGTestProject
//
//  Created by liugang on 2020/8/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionBlock) (NSError * _Nonnull error, id _Nullable obj);

NS_ASSUME_NONNULL_BEGIN

@interface LGAFNetWorkManager : NSObject

+(LGAFNetWorkManager *)shareManager;

// 网络请求
- (void)LGNetWorkingRequest:(NSString *)requestURL page:(NSInteger)page parameters:(NSDictionary *)parameters succeed:(completionBlock)succeedBlock failure:(completionBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
