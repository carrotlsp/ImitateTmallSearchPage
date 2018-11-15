//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//

#import "UILabel+HuaZhi.h"
#define labelHeight 30//label
#define spaceX 10
#define spaceY 10
@implementation UILabel (HuaZhi)

- (CGSize)nextOrgin:(CGSize)size
{
    CGSize sizexy=[self sizeWithString:self.text font:self.font];
    NSLog(@"width==%f",sizexy.width);
    //判断是否换行
    if (size.width+sizexy.width+10>[UIScreen mainScreen].bounds.size.width - 10) {
        //换行
        self.frame=CGRectMake(spaceX, size.height+labelHeight+spaceY, sizexy.width, labelHeight);
        size=CGSizeMake(2*spaceX+sizexy.width, size.height+labelHeight+spaceY);
    }else{
        //不换行
        self.frame=CGRectMake(size.width, size.height, sizexy.width, labelHeight);
         size=CGSizeMake(sizexy.width+size.width+spaceX, size.height);
    }
    return size;
}

//求出label的长度
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

@end
