//
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic) CGFloat dd_left;

@property (nonatomic) CGFloat dd_top;

@property (nonatomic) CGFloat dd_right;

@property (nonatomic) CGFloat dd_bottom;

@property (nonatomic) CGFloat dd_width;

@property (nonatomic) CGFloat dd_height;

@property (nonatomic) CGFloat dd_centerX;

@property (nonatomic) CGFloat dd_centerY;

@property (nonatomic) CGPoint dd_origin;

@property (nonatomic) CGSize dd_size;

@property (nonatomic) CGPoint dd_center;



+ (id _Nullable )dd_loadFromXIB;

+ (id _Nullable )dd_loadFromXIBName:(NSString *_Nullable)xibName;

- (void)dd_createBordersWithColor:(UIColor * _Nonnull)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width;

- (id _Nullable )subViewOfClassName:(NSString*_Nonnull)className;
@end
