//
//  LGAFNetWorkManager.m
//  LGTestProject
//
//  Created by liugang on 2020/8/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGAFNetWorkManager.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import <MJExtension.h>
#import "ProductModel.h"

@implementation LGAFNetWorkManager

+ (LGAFNetWorkManager *)shareManager{
    static LGAFNetWorkManager *lgNetManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lgNetManager  = [[LGAFNetWorkManager alloc]init];
    });
    return lgNetManager;
}

- (void)LGNetWorkingRequest:(NSString *)requestURL page:(NSInteger)page parameters:(NSDictionary *)parameters succeed:(completionBlock)succeedBlock failure:(completionBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
    [manager POST:requestURL parameters:@{
                                      @"category_id" : @"48",
                                      @"app" : @"higo",
                                      @"category_source" : @"1",
                                      @"client_id" : @"1",
                                      @"cver" : @"5.1.0",
                                      @"device_id" : @"h_13aa73608eac4f13a3a37987678ed986",
                                      @"device_model" : @"iPhone 6S Plus",
                                      @"device_token" : @"c8b128363664e6feda0bac9ae1931c53392994308e455ee1d481dc1108883402",
                                      @"device_version" : @"9.3.2",
                                      @"idfa" : @"2FF88C7F-0756-427B-A2A3-B7FB449D7043",
                                      @"open_udid" : @"cdec8d86d9b086f705183232c1f607a106fa42b3",
                                      @"p" : [NSString stringWithFormat:@"%ld",page],
                                      @"package_type" : @"1",
                                      @"qudaoid" : @"10000",
                                      @"uuid" : @"486b8b8fd7b0b02d3852841bcdf6bba6",
                                      @"ratio" : @"1242*2208",
                                      @"size" : @"30",
                                      @"ver" : @"0.8",
                                      @"via" : @"iphone"
                                      
    } headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [HigoList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_list":@"GoodsModel",@"banner":@"BannerImage"};
        }];
         HigoList *list =  [HigoList mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        if (succeedBlock) {
            succeedBlock(nil,list);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error,nil);
        }
    }];
}

@end
