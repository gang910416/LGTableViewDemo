//
//  ProductModel.h
//  LGTestProject
//
//  Created by liugang on 2020/8/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstImage : NSObject
@property (nonatomic,copy) NSString *image_original;
@end

@interface BannerImage : NSObject
@property (nonatomic,strong) FirstImage *banner_pic;
@end

@interface HigoList : NSObject

@property (nonatomic,strong) BannerImage *banner;
@property (nonatomic,strong) NSMutableArray *category_list;
@property (nonatomic,strong) NSMutableArray *goods_list;
@end

@interface SecondImage : NSObject
@property (nonatomic,copy) NSString *image_original;
@end

@interface CategoryModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) SecondImage *image;
@end

@interface ThirdImage : NSObject
@property (nonatomic,copy) NSString *image_original;
@end

@interface Address : NSObject
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *city;
@end

@interface GoodsModel : NSObject
@property (nonatomic,strong) ThirdImage *main_image;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_display_list_price;
@property (nonatomic,strong) Address *group_info;
@end

NS_ASSUME_NONNULL_END
