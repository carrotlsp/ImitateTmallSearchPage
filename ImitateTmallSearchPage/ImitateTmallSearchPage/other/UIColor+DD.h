//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (DD)
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHexString:(id)input;

+ (UIColor *)randomColor;
@end
